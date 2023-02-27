/* Les besoins d'affichage
1. Quelles sont les commandes du fournisseur n°9120 ? */

SELECT *
FROM entcom
WHERE numfou=9120;

/* 2. Afficher le code des fournisseurs pour lesquels des commandes ont été passées.*/

SELECT numfou
FROM entcom
GROUP BY numfou;

/* 3. Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés. */

SELECT COUNT(numcom), COUNT(DISTINCT(numfou))
FROM entcom;


/*4. Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000. 
Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)*/

SELECT codart, libart, stkale, stkphy, qteann
FROM produit
WHERE stkale <= stkphy AND qteann<1000;

/* 5. Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ? 
L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.*/

SELECT posfou, nomfou
FROM fournis
WHERE posfou != 85100 AND 59987  
ORDER BY nomfou, posfou DESC; 

/* 6. Quelles sont les commandes passées en mars et en avril ? */

SELECT*
from entcom
WHERE MONTH(DATCOM)=3 OR MONTH(DATCOM)=4;


/* 7. Quelles sont les commandes du jour qui ont des observations particulières ?
Afficher numéro de commande et date de commande */

SELECT*
FROM entcom
WHERE OBSCOM !="";



/* 8.  Lister le total de chaque commande par total décroissant.
Afficher numéro de commande et total */

SELECT entcom.numcom, SUM(priuni)
FROM entcom
JOIN ligcom ON entcom.numcom = ligcom.numcom
GROUP BY entcom.numcom
ORDER BY -SUM(priuni);

/* 9. Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000.
Afficher numéro de commande et total */

SELECT*, SUM(qtecde*priuni)
FROM entcom
JOIN ligcom ON entcom.numcom = ligcom.numcom
WHERE qtecde<1000
GROUP BY entcom.numcom
HAVING SUM(qtecde*priuni)>10000;

/* 10. Lister les commandes par nom de fournisseur.
Afficher nom du fournisseur, numéro de commande et date */

SELECT fournis.nomfou, numcom, datcom
from entcom
JOIN fournis ON entcom.numfou = fournis.numfou;



/* 11. Sortir les produits des commandes ayant le mot "urgent' en observation.
Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire) */

SELECT entcom.numcom, obscom, nomfou, libart, (qtecde*priuni) AS soustotal
FROM entcom
JOIN fournis ON entcom.numfou = fournis.numfou
JOIN vente ON fournis.numfou = vente.numfou
JOIN produit ON vente.codart = produit.codart
JOIN ligcom ON produit.codart = ligcom.codart
WHERE obscom = "commande urgente";

/* 12. Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article. */

/* Méthode 1*/

SELECT nomfou, SUM(qteliv)
FROM entcom
JOIN ligcom ON entcom.numcom = ligcom.numcom
JOIN fournis ON entcom.numfou = fournis.numfou
GROUP BY nomfou
HAVING sum(qteliv) > 1;


/* 13. Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210.
Afficher numéro de commande et date */

SELECT *
FROM entcom
WHERE numfou IN ( 

    SELECT numfou
    FROM entcom
    WHERE numcom = 70210

);
    
/* Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans (article dont le premier caractère commence par R). 
Afficher libellé de l’article et prix1 */



