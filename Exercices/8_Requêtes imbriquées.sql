/*
 * Liste des noms et prénoms de personnes qui ont passé des commandes
 * dont le montant est supérieur à la moyenne (de toutes les commandes)
 */
SELECT contactFirstName, contactLastName, TRUNCATE(SUM(priceEach * quantityOrdered), 2) AS totalAmount
fROM `customers`AS C
JOIN `orders`AS O2 USING (customerNumber)
JOIN `orderdetails`AS OD2 USING (orderNumber)
GROUP BY O.orderNumber
-- La clause HAVING permet de comparer le montant d'une commande (aui est une valeur agrégée)
-- avec la moyenne de toutes les commandes
HAVING totalAmount > (
		-- La requête qui calcule la valeur moyenne des commandes a pour source la _requête dérivée_
		-- qui calcule le montant de chaque commande.
		-- Il ne reste alors qu'à exécuter la fonction d'agrégation AVG, sans même avoir besoin de faire de groupement
		-- puisque l'on considère toutes les lignes en bloc.
    SELECT TRUNCATE(AVG(total) , 2) AS mean
    FROM (
				-- Pour trouver la valeur moyenne des commandes, il faut déjà calculer le montant total de chaque commande
				-- Celui-ci ne nous est pas donné, il faut calculer la valeur de chaque ligne et faire la somme des lignes
				-- pour chaque commande
        SELECT TRUNCATE(SUM(priceEach * quantityOrdered), 2) AS total
        FROM orderdetails AS OD
				NATURAL JOIN orders AS O
        GROUP BY O.orderNumber
			-- A noter que l'alias est obligatoire pour les requêtes dérivées, même s'il n'est pas utilisé
			) AS S
	)
ORDER BY totalAmount DESC


/*
 * Je suis client du magasin. Quels sont produits qu'achètent les clients qui ont les mêmes goûts que moi ?
 * (c'est-à-dire qui ont tendance à acheter les mêmes produits que moi)
 */

-- Version naïve
SELECT productCode, SUM(`quantityOrdered`) AS counts
FROM `orderdetails` AS OD
JOIN `orders` AS O
WHERE (
    customerNumber IN (
			-- Extraction de tous les codes client distincts
    	SELECT DISTINCT customerNumber
    	FROM (
				-- 2. Trouver les clients qui ont achetées les maquettes de (1)
				SELECT DISTINCT customerNumber, COUNT(productCode) AS sims
				FROM `orders`
				NATURAL JOIN `orderdetails` AS OD2
				WHERE productCode  IN (
					-- 1. Trouver les maquettes achetées par un certain client (ici n° 112)
       			SELECT DISTINCT productCode
       			FROM `orderdetails` AS OD3
       			NATURAL JOIN `orders` AS O
						WHERE customerNumber = 112
						)
				-- 3. Avec le GROUP BY, on récupère le nombre de maquettes pour chaque client
				-- On ne garde que ceux qui ont un “bon”taux de recouvrement (ici 30)
    		GROUP BY customerNumber
    		HAVING sims > 30
				ORDER BY sims DESC
				LIMIT 50
    		) AS S
    	)
AND (
		-- 7. Suppression de la liste des recommandations des maquettes que le client a déjà achetées
    productCode NOT IN (
       	SELECT DISTINCT productCode
       	FROM `orderdetails` AS OD3
       	NATURAL JOIN `orders` AS O
				WHERE customerNumber = 112
			)
    )
)
GROUP BY productCode
ORDER BY counts DESC

-- Version simplifiée
SELECT productCode, SUM(`quantityOrdered`) AS counts
FROM `orderdetails`
JOIN `orders`
WHERE (
    customerNumber IN (
				-- 2. Trouver les clients qui ont achetées les maquettes de (1)
				SELECT customerNumber
				FROM `orders`
				NATURAL JOIN `orderdetails`
				WHERE productCode  IN (
					-- 1. Trouver les maquettes achetées par un certain client (ici n° 112)
       			SELECT DISTINCT productCode
       			FROM `orderdetails`
       			NATURAL JOIN `orders`
						WHERE customerNumber = 112
						)
				-- 3. Avec le GROUP BY, on récupère le nombre de maquettes pour chaque client
				-- On ne garde que ceux qui ont un “bon”taux de recouvrement (ici 30)
    		GROUP BY customerNumber
    		HAVING COUNT(*) > 30
				ORDER BY COUNT(*) DESC
				LIMIT 50
    	)
AND (
		-- 7. Suppression de la liste des recommandations des maquettes que le client a déjà achetées
    productCode NOT IN (
       	SELECT DISTINCT productCode
       	FROM `orderdetails`
       	NATURAL JOIN `orders`
				WHERE customerNumber = 112
			)
    )
)
GROUP BY productCode
ORDER BY counts DESC














/*
 * Découpage de la requête avec des vues
 */

CREATE VIEW totalAmounts (amount, orderNumber, customerNumber, shippedDate)
AS  SELECT TRUNCATE(SUM(`quantityOrdered` * `priceEach`), 2), D.`orderNumber` , C.`customerNumber`, O.`shippedDate`
    FROM `orderdetails` AS D
    NATURAL JOIN `orders` AS O
    NATURAL JOIN `customers` AS C
    GROUP BY D.`orderNumber`

CREATE VIEW paymentDelay (delay)
AS SELECT `paymentDate` - `shippedDate`
	 FROM `payments` AS P
	 INNER JOIN `totalAmounts` AS X USING (`customerNumber`, `amount`)

SELECT COUNT(*) AS count, delay
	 FROM `paymentDelay`
	 GROUP BY delay
	 ORDER BY delay

WITH buyers AS (
	 	SELECT DISTINCT customerNumber
	 	FROM `orders`
	 	JOIN `customers` AS C USING (`customerNumber`)
	 	JOIN `orderdetails` AS OD USING (`orderNumber`)
	 	WHERE productCode = 'S10_1678'
)
SELECT productCode, SUM(OD2.`quantityOrdered`) AS counts
FROM `orderdetails` AS OD2
JOIN `orders` AS O
WHERE customerNumber IN (SELECT * FROM buyers)
GROUP BY productCode
ORDER BY counts DESC
