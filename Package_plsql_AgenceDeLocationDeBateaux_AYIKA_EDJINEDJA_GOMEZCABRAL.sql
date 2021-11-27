

                -------------------------------------------------------
				
				    ---PL/SQL
				
				-------------------------------------------------------


--Table A : CIENT
CREATE OR REPLACE PACKAGE pkg_client IS
PROCEDURE Ainserer (numero NUMBER, name VARCHAR2, surname VARCHAR2, codepostal NUMBER, town VARCHAR2, telephone VARCHAR2);
PROCEDURE Asupprimer (name VARCHAR2);
PROCEDURE AmodifierTelepnone(name VARCHAR2, telephone VARCHAR2);
PROCEDURE AmodifierTown(name VARCHAR2, town VARCHAR2);
PROCEDURE Alister ;
FUNCTION Atotal RETURN NUMBER;
FUNCTION Aconsulation1 RETURN VARCHAR2;
FUNCTION Aconsulation2 RETURN VARCHAR2;
FUNCTION Aconsulation3 RETURN VARCHAR2;

END pkg_client; 

CREATE OR REPLACE PACKAGE BODY pkg_client IS
--Procédure Ainserer
PROCEDURE Ainserer (numero NUMBER, name VARCHAR2, surname VARCHAR2, codepostal NUMBER, town VARCHAR2, telephone VARCHAR2) IS
BEGIN
INSERT INTO client (clnum,clnom,clprenom,clcp,clville,cltel)
VALUES (numero,name,surname,codepostal,town,telephone);
END; 

--Procédure Asupprimer ()
PROCEDURE Asupprimer (name VARCHAR2) IS
BEGIN
DELETE FROM client WHERE clnom = name;
END; 

--PROCEDURE AmodifierTelepnone
PROCEDURE AmodifierTelepnone(name VARCHAR2, telephone VARCHAR2) IS 
BEGIN
UPDATE client 
set cltel = telephone WHERE clnom=name;
END;

--PROCEDURE AmodifierTown
PROCEDURE AmodifierTown(name VARCHAR2, town VARCHAR2) IS
BEGIN
UPDATE client 
set clville = town WHERE clnom=name;
END;

--PROCEDURE Alister 
PROCEDURE Alister IS
BEGIN
DECLARE
CURSOR curseur_alister IS
SELECT  clnom ,clville FROM client ;
BEGIN
FOR v_client in curseur_alister
LOOP
DBMS_OUTPUT.PUT_LINE('Client : ' || UPPER(v_client.clnom)||
                      ' Ville : ' || v_client.clville);
END LOOP;
END;
END;


--Fonction Consultation1
FUNCTION Aconsulation1 RETURN VARCHAR2 IS
BEGIN 
RETURN 'Nom et ville des clients ayant memes numeros que les contrats et les propriétaires'
END;

--Fonction Consultation2
FUNCTION Aconsulation2 RETURN VARCHAR2 IS
BEGIN 
RETURN 'Nom des bateaux ayant pour port les noms de villes et pour numéros, ceux des propriétaires'
END;

--Fonction Consultation3
FUNCTION Aconsulation2 RETURN VARCHAR2 IS
BEGIN 
RETURN 'Noms des propriétaires ayant memes numéros que les bateaux et pour port les noms de villes'
END;

END pkg_client;




--Table B : ENTRETIEN
CREATE OR REPLACE PACKAGE pkg_entretien IS
PROCEDURE Binserer (numero NUMBER,datedebut date, datefin date );
PROCEDURE Bsupprimer (numero NUMBER);
PROCEDURE BmodifierEndf(numero number, datefin date);
PROCEDURE BmodifierEndd(numero number, datedebut date);
PROCEDURE Blister ;
END pkg_entretien;

CREATE OR REPLACE PACKAGE BODY pkg_entretien IS
--Procédure Binserer
PROCEDURE Binserer (numero NUMBER, datedebut date, datefin date) IS
BEGIN
INSERT INTO entretien (ennumero NUMBER, endd date, endf date)
VALUES (numero,datedebut,datefin);
END; 

--Procédure Bsupprimer (numero VARCHAR2)
PROCEDURE Bsupprimer (numero NUMBER) IS
BEGIN
DELETE FROM entretien WHERE ennumero = numero;
END; 

--PROCEDURE BmodifierEndf
PROCEDURE BmodifierEndf(numero number, datefin date) IS 
BEGIN
UPDATE entretien 
set endf = datefin WHERE ennumero=numero;
END;

--PROCEDURE BmodifierEndd
PROCEDURE BmodifierEndd(numero number, datedebut date) IS
BEGIN
UPDATE entretien
set endd = datedebut WHERE ennumero=numero;
END;

--PROCEDURE Blister 
PROCEDURE Blister IS
BEGIN
DECLARE
CURSOR curseur_blister IS
SELECT  endd , endf FROM entretien ;
BEGIN
FOR v_entretien in curseur_blister
LOOP
DBMS_OUTPUT.PUT_LINE('DateDebut : ' || v_entretien.endd||
                      ' DateFin : ' || v_entretien.endf);
END LOOP;
END;
END;

END pkg_entretien;



                -------------------------------------------------------
				
				    ---TEST DES FONCTIONS
				
				-------------------------------------------------------

--Ainserer
begin 
pkg_client.ainserer(13,'ALPHA','BETA',74100,'ANNEMASSE','3344009988');
end;

--Asupprimer
begin 
pkg_client.asupprimer('ALPHA');
end;

--AmodifierTelepnone
begin 
pkg_client.amodifiertelepnone('AYELE','2233665533');
end;


                -------------------------------------------------------
				
				    ---Definition des triggers
				
				-------------------------------------------------------

--Insertion
CREATE OR REPLACE trigger Trigger1 
after insert on tarif 
begin 
dbms_output.put_line('OK');
end; 
--test insertion
insert into tarif (tanumero,taprix) values(13,12000);  

--Mise à jour 
create or replace trigger Trigger2 
after update of taprix on tarif 
begin 
dbms_output.put_line('OK');
end;
--test Mise à jour
update tarif 
set taprix = 1200 where tanumero = 2; 

--Mise à jour avec each row
create or replace trigger Trigger3
before update of clville on client for each row 
begin 
dbms_output_line('OK'); 
end;
--test mise à jour avec each row 
update client set clville = clville where clnom = 'HENRY';
              