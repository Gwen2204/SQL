
/* 1. Ecrivez ensuite les requêtes permettant d'obtenir les résultats attendus suivants :*/
SELECT companyname AS 'société', contactname AS 'contact', contacttitle AS 'fonction', phone AS 'téléphone'
FROM customers 
WHERE country = "France";

/* 2. Liste des produits vendus par le fournisseur "Exotic Liquids" :*/

SELECT productname AS 'produit', unitprice AS 'prix'
FROM products
JOIN suppliers ON products.supplierID = suppliers.supplierID
WHERE suppliers.companyname = "exotic liquids";

/* 3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant) : */

SELECT companyname AS 'Fournisseurs', COUNT(productID) AS 'Nbre produits'
FROM products
JOIN suppliers ON products.supplierID = suppliers.supplierID
WHERE country = "France"
GROUP BY companyname
ORDER BY COUNT(ProductID) DESC;


/* 4. Liste des clients français ayant passé plus de 10 commandes : */

SELECT companyname AS CLIENT, COUNT(orders.CustomerID) AS 'Nbre commandes'
FROM customers INNER JOIN orders ON orders.customerID = customers.CustomerID
WHERE country = "France" 
GROUP BY orders.CustomerID
HAVING COUNT(orders.CustomerID)>10;

/* 5. Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :
NB: chiffre d'affaires (CA) = total des ventes */

SELECT companyname AS 'CLIENT', sum(UnitPrice*quantity) AS 'CA', Country AS 'Pays'
FROM customers JOIN orders ON orders.customerID = customers.CustomerID
JOIN `order details` ON `order details`.orderID = orders.orderID 
GROUP BY orders.CustomerID
HAVING sum(UnitPrice*quantity)>30000
ORDER BY CA DESC;

/* 6. Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés :*/

SELECT shipcountry AS 'Pays'
FROM `order details`
JOIN orders ON `order details`.orderID = orders.OrderID
JOIN products ON products.ProductID = `order details`.ProductID
JOIN suppliers ON suppliers.SupplierID = products.SupplierID AND suppliers.companyname = "exotic liquids"
GROUP BY shipcountry
ORDER BY shipcountry asc;

/* 7- Chiffre d'affaires global sur les ventes de 1997 :*/

SELECT SUM(UnitPrice*Quantity) AS 'Montant Ventes 97'
FROM `order details`
JOIN orders ON `order details`.orderID = orders.OrderID AND YEAR (OrderDate) ="1997";

/* 8- Chiffre d'affaires détaillé par mois, sur les ventes de 1997 : */

SELECT MONTH(OrderDate) AS 'Mois 97', SUM(UnitPrice*Quantity) AS 'Montant Ventes 97'
FROM `order details`
JOIN orders ON `order details`.orderID = orders.OrderID AND YEAR (OrderDate) ="1997"
GROUP BY MONTH(OrderDate);


/* 9- A quand remonte la dernière commande du client nommé "Du monde entier" ? */

SELECT OrderDate AS 'Date de dernière commande'
FROM `order details`
JOIN orders ON `order details`.orderID = orders.OrderID
JOIN customers ON customers.customerID = orders.CustomerID AND companyname = "Du monde entier" 
ORDER BY OrderDate DESC LIMIT 1;

/* 10- Quel est le délai moyen de livraison en jours ? */

SELECT ROUND (AVG(DATEDIFF(shippeddate, orderdate))) AS 'Délai moyen de livraison en jours' 
FROM orders;
