/*
 * Liste des noms et prénoms de personnes qui ont passé des commandes
 * dont le montant est supérieur à la moyenne (de toutes les commandes)
 * Version de la requête précédente avec une expression de contexte
 */
WITH
	-- L'expression de contexte (CTE) permet ici de mutualiser une requête qui est exécutée dux fois.
	-- Le gain d'efficacité est appréciabe puisque le temps d'exécution passe de ~ 9 ms à ~ 3.5 ms
	-- Globalement, cette version est 2.5 fois plus rapide.
	totalAmountCompute AS (
		SELECT contactFirstName, contactLastName, TRUNCATE(SUM(priceEach * quantityOrdered), 2) AS totalAmount
		fROM `customers`AS C
		JOIN `orders`AS O USING (customerNumber)
		JOIN `orderdetails`AS OD USING (orderNumber)
		GROUP BY O.orderNumber
	)
SELECT *
-- 1. utilisation de la CTE
FROM totalAmountCompute
HAVING totalAmount > (
	-- 2. utilisation de la CTE
	SELECT TRUNCATE(AVG(totalAmount), 2) FROM totalAmountCompute
)


/*
 * Je suis client du magasin. Quels sont produits qu'achètent les clients qui ont les mêmes goûts que moi ?
 * (c'est-à-dire qui ont tendance à acheter les mêmes produits que moi)
  * Version optimisée utilisant des expressions de contexte
 */
SET @idCustomer := 112, @commons := 30;
WITH
joinedOrders AS (
	SELECT productCode, customerNumber, quantityOrdered, productName
	FROM `orderdetails` AS OD
	NATURAL JOIN `orders` AS O
	NATURAL JOIN `products` AS P
),
codesByCustomer AS (
	SELECT productCode
	FROM joinedOrders
	WHERE customerNumber = @idCustomer
)
SELECT productCode, productName, SUM(`quantityOrdered`) AS counts
FROM joinedOrders
WHERE (
    customerNumber IN (
    	SELECT DISTINCT customerNumber
    	FROM (
				SELECT DISTINCT customerNumber, COUNT(productCode) AS sims
				FROM joinedOrders
				WHERE productCode IN ( SELECT * FROM codesByCustomer	)
    		GROUP BY customerNumber
    		HAVING sims > @commons
    		) AS S
    	)
AND (
    productCode NOT IN ( SELECT * FROM codesByCustomer )
    )
)
GROUP BY productCode
ORDER BY counts DESC

/*
 * Version utilisant des vues
 */
CREATE VIEW joinedOrders
AS SELECT productCode, customerNumber, quantityOrdered, productName
FROM `orderdetails` AS OD
NATURAL JOIN `orders` AS O
NATURAL JOIN `products` AS P;

SET @iCustomer = 112;
-- DROP VIEW IF EXISTS commandes;
CREATE OR REPLACE VIEW codesByCustomer
AS SELECT productCode
FROM joinedOrders
WHERE customerNumber = @idCustomer;

SELECT productCode, productName, SUM(`quantityOrdered`) AS counts
FROM joinedOrders
WHERE (
    customerNumber IN (
    	SELECT DISTINCT customerNumber
    	FROM (
				SELECT DISTINCT customerNumber, COUNT(productCode) AS sims
				FROM joinedOrders
				WHERE productCode IN ( SELECT * FROM codesByCustomer	)
    		GROUP BY customerNumber
    		HAVING sims > @commons
    		) AS S
    	)
AND (
    productCode NOT IN ( SELECT * FROM codesByCustomer )
    )
)
GROUP BY productCode
ORDER BY counts DESC

/* Les maquettes qui ont été aussi achetées par les clients qui ont acheté une certaine maquette (on retiendra les 10 plus vendues) */
-- Affectation d'une variable SQL “persistante”
-- ELle contient le code du produit de référence
SET @reference = 'S10_1678';
-- On cherche le nom d'un produit et la quantité qu'en ont achté un sous-ensemble particulier des clients
SELECT `productName`, `productVendor`, COUNT(*) AS quantitySold
FROM `products` AS P
NATURAL JOIN `orderdetails` AS D2
NATURAL JOIN `orders` AS O2
WHERE O2.customerNumber IN (
	-- On cherche les cleints qui ont acheté un certaine maquette.
	-- La liste de ces clients servira de référence.
	-- Nous allons pouvoir cherche la liste des maquettes achetées pas ces clients en particulier
	SELECT DISTINCT customerNumber
	FROM `customers` AS C
	NATURAL JOIN `orders`AS O
	NATURAL JOIN `orderdetails` AS D
	WHERE D.productCode = @reference
	-- Groupement selon le code produit pour pouvoir compter lenombre d'exemplaires vendus
)
GROUP BY P.`productCode`
-- Tri par quantité vendue décroissante pour pouvoir prendre les 10 premières lignes
ORDER BY quantitySold DESC
-- Limitation des résultats à 1 lignes
LIMIT 10
