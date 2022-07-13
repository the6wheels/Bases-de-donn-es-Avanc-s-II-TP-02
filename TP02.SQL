CREATE OR REPLACE TYPE Tel AS VARRAY(5) OF VARCHAR2(25);
/

CREATE OR REPLACE TYPE Ville_t AS OBJECT(Nom VARCHAR(20), 
										 CP NUMBER(6));
/


CREATE OR REPLACE TYPE Adresse_t AS OBJECT(Numero NUMBER(6),
										   Rue varchar(50),
							   			   Ville Ville_t);
/
							  
							   
						
							  
CREATE OR REPLACE TYPE Etudiant_t AS OBJECT(Matricule NUMBER,
										   Nom VARCHAR(20),
										   Prenom VARCHAR(20),
										   Age NUMBER(6),
										   Adresse Adresse_t,
										   Telephone Tel)
										   NOT FINAL;
/
							   
							  
CREATE OR REPLACE TYPE EtudFctionnaire_t 
UNDER Etudiant_t(Salaire NUMBER(6));
/



CREATE TABLE Ville OF Ville_t;


CREATE TABLE Adresse OF Adresse_t;


CREATE TABLE Etudiant OF Etudiant_t(PRIMARY KEY (Matricule));


CREATE TABLE EtudFctionnaire OF 
EtudFctionnaire_t(PRIMARY KEY (Matricule));



DESC Ville;
DESC Adresse;
DESC EtudFctionnaire;
DESC Etudiant;

SELECT * FROM user_types;




INSERT INTO Adresse(Numero, Rue) VALUES (35,'rue Independance');
INSERT INTO Adresse(Numero, Rue) VALUES (25,'rue Emir AEK');
INSERT INTO Adresse(Numero, Rue) VALUES (12,'rue Didouche');
INSERT INTO Adresse(Numero, Rue) VALUES (10,'rue de la Paix');

SELECT * FROM Adresse;

INSERT INTO Ville(Nom, CP) VALUES ('SBA',22000);
INSERT INTO Ville(Nom, CP) VALUES ('ORAN',31000);
INSERT INTO Ville(Nom, CP) VALUES ('ALGER',16000);

SELECT * FROM Ville;


INSERT INTO EtudFctionnaire(Matricule, Nom, Prenom, Age, Salaire, Adresse, Telephone) 
VALUES ( 1, 'BILAL', 'Amina', 32, 35000, Adresse_t(25, 'rue Emir AEK', Ville_t('Oran', 31000)), 
Tel('0555421699', '0656114445'));

INSERT INTO EtudFctionnaire(Matricule, Nom, Prenom, Age, Salaire, Adresse, Telephone) 
VALUES ( 2, 'SEHIL', 'Mohamed', 40, 50000, Adresse_t(10, 'rue de la Paix', Ville_t('Alger', 16000)), 
Tel('0554324545', '0777234512', '0543101023'));

INSERT INTO EtudFctionnaire(Matricule, Nom, Prenom, Age, Salaire, Adresse, Telephone) 
VALUES ( 3, 'ABDIN', 'Ahmed', 35, 50000, Adresse_t(103, 'rue Didouche', Ville_t('Alger', 16000)), 
Tel('0654324545', '0547234512'));

INSERT INTO EtudFctionnaire(Matricule, Nom, Prenom, Age, Salaire, Adresse, Telephone) 
VALUES ( 4, 'Amine', 'Mostafa', 25, 50000, Adresse_t(102, 'rue Independance', Ville_t('Alger', 16000)), 
Tel('0556567001'));

select * from EtudFctionnaire;


UPDATE EtudFctionnaire 
SET Adresse = Adresse_t(10, 'rue liberte', Ville_t('SBA', 22))
WHERE Matricule = 2;

select * from EtudFctionnaire;

SELECT e.Nom FROM EtudFctionnaire e WHERE e.Adresse.Ville.Nom = 'Alger';



SELECT e.Nom, e.PRENOM FROM EtudFctionnaire e WHERE e.SALAIRE > 30000;



SELECT e.adresse.ville.nom, COUNT(e.Matricule) FROM EtudFctionnaire e GROUP BY e.adresse.ville.nom ;




