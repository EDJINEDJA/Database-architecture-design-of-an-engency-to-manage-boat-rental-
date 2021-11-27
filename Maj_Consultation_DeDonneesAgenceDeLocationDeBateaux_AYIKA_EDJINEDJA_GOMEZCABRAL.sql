
                -------------------------------------------------------
				
				    ---MISE A JOUR
				
				-------------------------------------------------------


---2 requete impliquant une table

---Mise a jour des salaires des employers qui ont pour proession Agent_Entretient 


UPDATE EMPLOYE
SET EMSALAIRE= 2*EMSALAIRE
WHERE EMPROFESSION='AGENTENTRETIENT'

---Mise a jour du code postale et de la ville du proprietaire au nom de FREDERICK 


UPDATE PROPRIETAIRE 
SET PRCP= 06200 ,
PRVILLE='NICE'
WHERE PRNOM='FREDERICK'

----Mise a jour du tarif numeros 6

UPDATE TARIF
SET TAPRIX=1110
WHERE TANUMERO=6;

---2 requete impliquant deux table

---Mise a jour du nom du port du bataeu du proprietaire ZO

UPDATE BATEAU 
SET BAPORT='ZOROBAR'
WHERE BATEAU.PRNUMERO=(SELECT PRNUMERO FROM PROPRIETAIRE WHERE PRNOM='ZO');

---Mise a jour de la date de fin de contrat  du client de nom de TORRES

UPDATE CONTRAT
SET CODF=to_date('21-11-2010','DD-MM-YYYY')
WHERE CONTRAT.CLNUM =(SELECT CLNUM FROM CLIENT WHERE CLNOM='TORRES');

---2 requete impliquant trois table
INSERT INTO TRAJET(TRNUMERO,TRDD,TRDA,TRPD,TRPA)
VALUES(13,to_date('12-06-2019','DD-MM-YYYY'),to_date('13-06-2019','DD-MM-YYYY'),'BREETAGNE','NICE')

---Mise a jour de la capaciter du bateaux qui coute 10.000 euros  et du port  du proprietaire ZO

UPDATE BATEAU 
SET BACAPACITER=100 ,BAPORT='NICE'
WHERE BATEAU.PRNUMERO=(SELECT PRNUMERO FROM PROPRIETAIRE WHERE PRNOM='ZO') 
AND BATEAU.TANUMERO=(SELECT TANUMERO FROM TARIF WHERE TAPRIX=10000)  ;

---Mise a jour de la capaciter du bateaux qui coute 1000 euros du proprietaire BUBBA

UPDATE BATEAU 
SET BACAPACITER=9
WHERE BATEAU.PRNUMERO=(SELECT PRNUMERO FROM PROPRIETAIRE WHERE PRNOM='BEETHOVEN') 
AND BATEAU.TANUMERO=(SELECT TANUMERO FROM TARIF WHERE TAPRIX=200)  ;


                -------------------------------------------------------
				
				    ---SUPPRESSION
				
				-------------------------------------------------------

---2 requete impliquant une table

---Suppression de bateau ou le nom est TITAN

DELETE FROM BATEAU
WHERE BANOM = 'TITAN';

---Suppression du bateau numero 1

DELETE FROM BATEAU 
WHERE BANUMERO=1;





---2 requetes impliquant deux tables

---Suppression du bateau du proprietaire ALBERT
DELETE FROM BATEAU 
WHERE BATEAU.PRNUMERO=(SELECT PRNUMERO FROM PROPRIETAIRE WHERE PRNOM='ALBERT');

--Suppression des bateaux ayant pour date de creation de contrat une date donnée
DELETE FROM BATEAU 
WHERE BATEAU.CONUMERO = SOME(SELECT CONUMERO FROM CONTRAT WHERE CODC=to_date('04-07-2019','DD-MM-YYYY')); 


---2 requetes impliquant trois tables

--suppression du bateau qui coûte 10.000 Euros et dont le proprietaire est ZO
DELETE FROM BATEAU 
WHERE BATEAU.PRNUMERO=(SELECT PRNUMERO FROM PROPRIETAIRE WHERE PRNOM='ZO') 
AND BATEAU.TANUMERO=(SELECT TANUMERO FROM TARIF WHERE TAPRIX=10000);

--Suppression du bateau  qui coute 1000 euros du proprietaire BUBBA
DELETE FROM BATEAU 
WHERE BATEAU.PRNUMERO=(SELECT PRNUMERO FROM PROPRIETAIRE WHERE PRNOM='BEETHOVEN') 
AND BATEAU.TANUMERO=(SELECT TANUMERO FROM TARIF WHERE TAPRIX=200) ;

                -------------------------------------------------------
				
				    ---CONSULTATION
				
				-------------------------------------------------------
--5 requêtes impliquant 1 table dont 1 avec un group By et une avec un Order By

--consultation de toutes les colonnes de EMPLOYE
SELECT * FROM EMPLOYE;

--consultation des nom des employés
SELECT EMNOM FROM EMPLOYE;

--consultation des noms des bateaux ayant un prix compris entre 200 et 10000 EUROS
SELECT BANOM FROM BATEAU
WHERE BATEAU.TANUMERO IN (SELECT TANUMERO FROM TARIF WHERE TAPRIX BETWEEN 200 AND 10000);

--Consultation des noms, prix et ports des bateaux triés par ordre croissant sur les noms
SELECT BANOM, BATYPE, BAPORT FROM BATEAU
ORDER BY BANOM ASC;

--Consultation du nombre d'employés groupés par profession
SELECT COUNT(*) FROM EMPLOYE
GROUP BY EMPROFESSION; 


---5 requêtes impliquant 2 tables avec jointures internes dont 1 externe + 1 group by + 1 tri 

----Donner la liste des proprietaires  et les numéros de Bateau qu'ils possedent et Pour ceux qui n'en possedent  aucun, leur nom doit être affiché grouper par nom en ordre croissant.

SELECT PRNOM,COUNT(BANUMERO) FROM PROPRIETAIRE P ,BATEAU B 
WHERE P.PRNUMERO=B.PRNUMERO(+)
GROUP BY PRNOM
ORDER BY PRNOM;

----Nom des prorietaires ayant les memes numeros que les bateaux
SELECT PRNOM FROM PROPRIETAIRE P 
INNER JOIN BATEAU  B ON  P.PRNUMERO=B.BANUMERO ;

----Nom des client ayant memes numero que les contrats

SELECT CLNOM FROM CLIENT C 
INNER JOIN CONTRAT  CL ON  C.CLNUM=CL.CONUMERO ;

----Les bateaux ayant pour port les noms des villes


SELECT BATYPE FROM BATEAU B
INNER JOIN PORT P ON B.BAPORT=P.POVILLE;

---Les contrats ayant pour date de debut les dates de debut d'entretien 

SELECT CONUMERO FROM CONTRAT C
INNER JOIN ENTRETIEN E ON C.CODC=E.ENDD;

---5 requêtes impliquant plus de 2 tables avec jointures internes dont 1 externe + 1 group by + 1 tri


SELECT PRNOM,COETAT FROM PROPRIETAIRE P ,BATEAU B ,CONTRAT C
WHERE P.PRNUMERO=B.PRNUMERO(+) AND C.CONUMERO =B.CONUMERO
ORDER BY PRNOM;

--Noms et villes des clients ayant  memes numeros que les contrats et les propriétaires
SELECT CLNOM, CLVILLE FROM CLIENT C 
INNER JOIN CONTRAT  CL ON  C.CLNUM=CL.CONUMERO
INNER JOIN PROPRIETAIRE PR ON C.CLNUM = PR.PRNUMERO;

--Noms des propriétaires ayant memes numéros que les bateaux et pour port les noms de villes
SELECT PRNOM FROM PROPRIETAIRE P 
INNER JOIN BATEAU  B ON  P.PRNUMERO=B.BANUMERO
INNER JOIN PORT PO ON P.PRVILLE=PO.POVILLE; 

--Nom des bateaux ayant pour port les noms de villes et pour numéros, ceux des propriétaires
SELECT BANOM FROM BATEAU B
INNER JOIN PORT P ON B.BAPORT=P.POVILLE
INNER JOIN PROPRIETAIRE PR ON B.PRNUMERO = PR.PRNUMERO;

--Contrats ayant pour date de debut les dates de debut d'entretien et pour numeros les numeros des clients
SELECT CONUMERO FROM CONTRAT C
INNER JOIN ENTRETIEN E ON C.CODC=E.ENDD
INNER JOIN CLIENT CL ON C.CONUMERO = CL.CLNUM;

 







