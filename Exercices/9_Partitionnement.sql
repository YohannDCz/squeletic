/*
 * Version de la même requête avec partitionnement (ou fonction de fenêtrage)
 */
SELECT *
FROM
	(
		-- Le résultat de la somme sur une partition ne peut pas être utilisé directement dans une cklause HAVING
		-- Pour cette raison, nous soemmes obligés d'imbirquer cette requête dans une autre dont le seul objet sera
		-- d'exécuter la restriction (directement avec WHERE)
		SELECT DISTINCT customerNumber, customerName, country , (SUM(amount) OVER (PARTITION BY P.customerNumber)) AS total
		FROM customers AS C
		NATURAL JOIN payments AS P
		WHERE country IN ('France', 'USA', 'Germany')
	) AS S
WHERE total > 50000

/*
 * Distribution par déciles des délais de paiement
 */
SELECT MIN(delay) AS min, MAX(delay)AS max, COUNT(delay) AS card, decile
FROM (

	SELECT delay, NTILE(10) OVER w AS decile
	FROM (
		-- Dans un premier temps, nous devons calculer le temps écoulé entre la date d'expédition et la date de paiement
		SELECT DATEDIFF(paymentDate, shippedDate) AS delay
		FROM `payments` AS P
		NATURAL JOIN `customers` AS C
		NATURAL JOIN `orders` AS O
		WHERE O.`status` LIKE 'Shipped'
		HAVING delay IS NOT NULL
		ORDER BY delay
	) AS D
	WINDOW w AS (ORDER BY delay)
) AS H
GROUP BY decile
ORDER BY decile

/*
 * Délais de paiement par commande et par client avec moyenne globale
 */
 SELECT
 		C.`customerNumber`,
    C.`country`,
    P.`amount`,
    T.`orderNumber`,
    T.`shippedDate`,
    P.`paymentDate`,
    (P.`paymentDate` - T.`shippedDate`) AS delay,
    (AVG(`paymentDate` - `shippedDate`) OVER (PARTITION BY C.`customerNumber`)) AS meanDelayByClient,
    (AVG(`paymentDate` - `shippedDate`) OVER ()) AS globalMeanDelay
     -- AVG(`paymentDate` - `shippedDate`) AS meanDelay
FROM `customers` AS C
NATURAL JOIN `payments` AS P
INNER JOIN (
     SELECT DISTINCT
 			O.`orderNumber` AS orderNumber,
     	O.`customerNumber` AS customerNumber,
     	O.`shippedDate` AS shippedDate,
 			ROUND(SUM(`priceEach` * `quantityOrdered`), 2) AS orderAmount
 	FROM `orders` AS O
 	NATURAL JOIN `orderdetails` AS D
 	WHERE O.`status` = 'Shipped'
     GROUP BY O.`orderNumber`
     ) AS T ON T.`customerNumber` = C.`customerNumber` AND T.`orderAmount` = P.`amount`
 -- GROUP BY C.`customerNumber`, T.`orderNumber`
 ORDER BY C.`customerNumber`

 /*
  * Pays dans lesquels le délai de paiement est en moyenne supérieur à la moyenne
  */
	WITH
	orderAmounts AS (
	    SELECT DISTINCT
			O.`orderNumber` AS orderNumber,
	    	O.customerNumber AS customerNumber,
	    	O.`shippedDate` AS shippedDate,
			ROUND(SUM(`priceEach` * `quantityOrdered`), 2) AS orderAmount
		FROM `orders` AS O
		NATURAL JOIN `orderdetails` AS D
		WHERE O.`status` = 'Shipped'
	    GROUP BY O.`orderNumber`
	),
	paymentDelays AS (
	SELECT DISTINCT
	    C.`country`,
	    (AVG(`paymentDate` - `shippedDate`) OVER (PARTITION BY C.`country`)) AS meanDelayByClient,
	    (AVG(`paymentDate` - `shippedDate`) OVER ()) AS globalMeanDelay
	FROM `customers` AS C
	NATURAL JOIN `payments` AS P
	INNER JOIN (
	    	SELECT * FROM orderAmounts
	    ) AS T ON T.`customerNumber` = C.`customerNumber` AND T.`orderAmount` = P.`amount`
	WHERE C.`country`NOT LIKE 'Australia'
	GROUP BY c.`country`
	ORDER BY `meanDelayByClient`
	)
	SELECT DISTINCT
		country,
	    meanDelayByClient - globalMeanDelay AS overrun
	FROM paymentDelays
	WHERE (meanDelayByClient - globalMeanDelay) > 0
	ORDER BY overrun DESC
