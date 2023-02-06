/*
 * Lister les noms et prenoms de toutes les personnes (clients + employés)
 * (UNION)
 */
SELECT firstName, lastName FROM employees
UNION
SELECT contactFirstName, contactLastName FROM customers


/*
 * Lister les noms de pays où nous avons à la fois des clients et des bureaux
 * (INTERSECT)
 */
SELECT DISTINCT country
FROM customers
-- Nous vérifions ici que le pays du client se trouve bien dans la liste des pays des bureaux
-- Ainsi nous ne retenons que l'intersection des deux ensembles.
WHERE country IN (
	SELECT DISTINCT country FROM offices
)


/*
 * Lister les oms des pays des clients où nous n'avons pas de bureaux
 * (MINUS) Exclusion
 */
SELECT DISTINCT country
FROM customers
-- Inversement, nous vérifions que le pays du client _ne se trouve pas_ dans la liste des pays des bureaux
WHERE country NOT IN (
	SELECT DISTINCT country FROM offices
)
