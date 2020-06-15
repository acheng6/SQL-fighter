/*
SQL FROM "ITCS3160 Chapter 05 RDMS and SQL CREATE ALTER INDEX."
   1. DROP classdemo DB
   2. ReCREATE classdemo DB
   3. USE to set classdemo active DB
   4. DROP table1
   5. ReCREATE table1
   6. DROP table2
   7. ReCREATE table2
   8. DROP table3
   9. ReCREATE table3
  10. INSERT records into table1, table2, and table3
  11. ALTER table1 by ADDing FK link to table2
  12. CREATE additional index for table 1
  13. Various forms of DELETEs on table3
  14. Setting SQL_SAFE_UPDATES switch ON/OFF
  15. Various forms of UPDATES on table3
  16. Sixth record added to table3, same t3Fraction, different t3Date
  17. Add SHOW tables command
  18. Add three groups of SELECT: basic, functions, two-table simple, ORDER BY/GROUP BY
  19. Added records to table1 and table2 to support LIKE wildcard query
  20. ADD SELECT queries with LIKE
  21. Add examples of =, IN, EXISTS, NOT EXISTS subqueries
  22. Create and query a view.
  23. Create queries with JOINS
  24. Create and test a procedure, a function, and two triggers
  25. Create amd insert table4
  26.  Add union samples including table3 and table4
*/  
DROP DATABASE IF EXISTS classdemo;
CREATE DATABASE IF NOT EXISTS classdemo;
USE classdemo;
DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (
  t1Key INT NOT NULL PRIMARY KEY,
  t1Color VARCHAR(10) NULL,
  t1Age INT,
  t1Tree VARCHAR(20) DEFAULT 'OAK',
  t2Key INT DEFAULT NULL
--  CHECK (t1Age>=21)
--  CONSTRAINT FK_T2 FOREIGN KEY (t2Key) REFERENCES table2(t2Key),
--  CONSTRAINT C1_Color CHECK (t1Color='RED' OR t1Color='BLUE' OR t1Color IS NULL)
); 

DROP TABLE IF EXISTS table2;
CREATE TABLE table2 (
  t2Key INT NOT NULL,
  t2Color VARCHAR(10) NULL, -- CHECK (t2Color='BLUE' OR t2Color IS NULL),
  t1Key INT DEFAULT NULL,
  CONSTRAINT FK_T1 FOREIGN KEY (t1Key) REFERENCES table1(t1Key)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  PRIMARY KEY (t2Key)
); 

DROP TABLE IF EXISTS table3;
CREATE TABLE table3 (
  t3Key INT AUTO_INCREMENT,
  t3Fraction FLOAT,
  t3Date Date DEFAULT '2019-02-20',
  PRIMARY KEY (t3Key)
); 

INSERT INTO table1 (t1Key, t1Color, t1Age, t1Tree, t2Key)
       VALUES(1, 'RED', 25, 'OAK', 1);
INSERT INTO table1 (t1Key, t1Color, t1Age, t1Tree, t2Key)
       VALUES(2, 'GREEN', 22, DEFAULT, 2);
INSERT INTO table1
       VALUES(3, 'ORANGE', 30, DEFAULT, 3);
INSERT INTO table1
       VALUES(4, 'Violet', 42, DEFAULT, 4);
INSERT INTO table2 (t2Key, t2Color, t1Key)
       VALUES(1, 'BLUE', 1);
INSERT INTO table2 (t2Key, t2Color, t1Key)
       VALUES(2, 'Green', 2);
INSERT INTO table2 
       VALUES(3, 'Purple', 3);
INSERT INTO table2 
       VALUES(4, 'Blue_Green', 4);
INSERT INTO table3 (t3Fraction)
       VALUES(13.295);       
INSERT INTO table3 (t3Fraction, t3Date)
       VALUES(101.23, '2019-02-23');       
INSERT INTO table3 (t3Fraction)
       VALUES(500);       
INSERT INTO table3 (t3Fraction, t3Date)
       VALUES(500, '2019-2-24');       
INSERT INTO table3 (t3Fraction, t3Date)
       VALUES(500, '2019-2-25');       
INSERT INTO table3 (t3Fraction, t3Date)
       VALUES(1001.99, '2021-5-11');       
INSERT INTO table3 (t3Fraction, t3Date)
       VALUES(1001.99, '2021-5-29');       
	   
ALTER TABLE table1 
 ADD CONSTRAINT FK_T2 FOREIGN KEY (t2Key) REFERENCES table2(t2Key)
;

CREATE INDEX table1_AgeIndex ON table1 (t1Age ASC);

 SET SQL_SAFE_UPDATES = 1;
 SHOW VARIABLES LIKE 'SQL_SAFE_UPDATES';
 
 USE classdemo;
 SET SQL_SAFE_UPDATES = 1;
 Delete FROM table1
 WHERE AlphaAlpha
 
 
 /*
DELETE FROM table3
   WHERE t3Fraction = 500;
   
DELETE FROM table3
   WHERE t3Key = 2;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM table3
   WHERE t3Fraction = 500;
   
DELETE FROM table3
   LIMIT 1;

DELETE FROM table3;

SET SQL_SAFE_UPDATES = 1;
 */
 
 /*
-- SET SQL_SAFE_UPDATES = 0;
UPDATE table3
   SET t3Date = '2017-11-5'
   WHERE t3Fraction = 500;
-- SET SQL_SAFE_UPDATES = 1;
   
UPDATE table3
   SET t3Date = '2022-9-24'
   WHERE t3Key = 4; -- this is a key which is why you do not need to change SET SQL_SAFE_UPDATES =0;
    
UPDATE table3
   SET t3Date = '2022-9-27',
       t3Fraction = -42.8
   WHERE t3Key = 4;
    
 UPDATE table3
   SET t3Date = '2017-11-5'
   WHERE t3Fraction = 500;
   
-- SET SQL_SAFE_UPDATES = 0;
UPDATE table3
   SET t3Fraction = 1,
       t3Date = '2011-4-12';
-- SET SQL_SAFE_UPDATES = 1;
*/

 /*  SELECT
SHOW tables;

SELECT * FROM table3;

SELECT t3Fraction, t3Date
   FROM table3;
SELECT t3Fraction
   FROM table3;
SELECT DISTINCT t3Fraction
   FROM table3;
SELECT table3.t3Fraction
   FROM table3;
SELECT t3.t3Key, t3.t3Date
   FROM table3 t3;

SELECT COUNT(t3Fraction)
   FROM table3;
SELECT COUNT(t3Fraction)
   FROM table3
   WHERE t3Fraction = 500;
SELECT COUNT(DISTINCT t3Fraction)
   FROM table3;
SELECT AVG(t3Fraction)
   FROM table3;
SELECT AVG(t3Fraction) AS Average
   FROM table3;
SELECT SUM(t3Fraction) AS 'Sum'
   FROM table3;
SELECT MAX(t3Fraction) AS 'Max'
   FROM table3;
SELECT MIN(t3Fraction)
   FROM table3;

SELECT t2.t2Color, t1.t1Color
   FROM table2 t2, table1 t1
   WHERE t1.t1Key = 1;
SELECT t2.t2Color, t1.t1Color
   FROM table2 t2, table1 t1
   WHERE t1.t1Key = 1 AND
         t1.t1Key = t2.t2Key;
SELECT t2.t2Color, t1.t1Color
   FROM table2 t2, table1 t1
   WHERE t1.t1Key = 1 OR
         t1.t1Key = t2.t2Key;
         
SELECT COUNT(t3.t3Fraction),t3.t3Fraction
   FROM table3 as t3
   GROUP BY t3.T3Fraction;
SELECT t3.t3Key, t3.t3Fraction, t3.t3Date
   FROM table3 as t3
   ORDER BY t3.T3Fraction DESC;
SELECT t3.t3Key, t3.t3Fraction, t3.t3Date
   FROM table3 as t3
   ORDER BY t3.T3Fraction ASC;
SELECT t3.t3Key, t3.t3Fraction, t3.t3Date
   FROM table3 as t3
   ORDER BY t3.T3Date;
   */
SELECT t3.t3Key, t3.t3Fraction, t3.t3Date AS 'Date'
   FROM table3 as t3
   ORDER BY t3.T3Date;


-- SELECT Queries and Subqueries
SELECT t2.t2Color
   FROM table2 t2
   WHERE t2.t1Key = 2;
/*
SELECT t2.t2Color
   FROM table2 t2
   WHERE t2.t2Color LIKE '%r%';
         
SELECT t2.t2Color
   FROM table2 t2
   WHERE t2.t2Color LIKE '_r%';
         
SELECT t2.t2Color
   FROM table2 t2
   WHERE t2.t2Color LIKE '%\_%';
         
SELECT t3.t3Fraction
   FROM table3 t3
   WHERE t3.t3Fraction BETWEEN 100 AND 600;
         
SELECT DISTINCT t3.t3Fraction
   FROM table3 t3
   WHERE t3.t3Fraction BETWEEN 100 AND 600;
         
SELECT t2.t2Color
   FROM table2 t2, table1 t1
   WHERE t1.t1Key = 1 AND
         t1.t1Key = t2.t2Key;
*/
SELECT t2.t2Color
   FROM table2 t2
   WHERE t2.t2Key = (SELECT t1.t1Key
                        FROM table1 t1
                        WHERE t1.t1Key = 1);
SELECT * FROM table1;
SELECT * FROM table2;
SELECT t2.t2Color
   FROM table2 t2
   WHERE t2.t2Key IN (SELECT t1.t1Key
                        FROM table1 t1
                        WHERE t1.t1Key = 1 OR
                              t1.t1Key = 43);
/*
SELECT t2.t2Color
   FROM table2 t2
   WHERE EXISTS (SELECT t1.t1Key
                   FROM table1 t1
                   WHERE t1.t1Key = t2.t2Key AND
                         t1.t1Color = 'Red');

SELECT t2.t2Color
   FROM table2 t2
   WHERE NOT EXISTS (SELECT t1.t1Key
                       FROM table1 t1
                       WHERE t1.t1Key = t2.t2Key AND
                             t1.t1Color = 'Red');

DROP VIEW IF EXISTS newView;
                           
CREATE VIEW newView
   AS SELECT t1.t1Tree, t2.t2Color, t3Fraction
         FROM table1 t1, table2 t2, table3 t3
         WHERE t1.t1Color = 'GREEN' AND
               t2.t2Color != 'BLUE' AND
               (t3.t3Fraction > 99 AND t3.t3Fraction <= 500);
               
 SELECT *
   FROM newView;               

*/

/* JOINS
-- Cartesian product, duplicates
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1, table2 t2;
   
-- natural join
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1, table2 t2
   WHERE t1.t1Key = 1;
   
-- multiple conditions
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1, table2 t2
   WHERE t1.t1Key = 1 AND
         t2.t2Color = 'Purple';
         
-- inner join
*/
SELECT * from table1;
Select * from table2;
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1
   INNER JOIN table2 t2 ON t1.t2Key = t2.t2Key;

-- inner join, multiple conditions
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1
   INNER JOIN table2 t2 ON t1.t2Key = t2.t2Key
   WHERE t1.t1Age > 22;

-- left join

SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1
   LEFT JOIN table2 t2 ON t2.t2Color = 'Blue';
   
-- right join
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1
   RIGHT JOIN table2 t2 ON t2.t2Color = 'Blue';
   
   SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1
   RIGHT JOIN table2 t2 ON t1.t2Key = t2.t2Key;
   
-- right join by t2Color = 'Green'
SELECT t1.t1Color, t1.t1Age, t2.t2Color
   FROM table1 t1
   RIGHT JOIN table2 t2 ON t1.t2Key = t2.t2Key
   WHERE t2.t2Color = 'Green';


/*  HAVING, Procedures, Functions, and Triggers
SELECT COUNT(t3Fraction) AS Counter, t3Fraction, t3Date
   FROM table3
   GROUP BY t3Fraction;
   
-- This query will fail because aggregatign function (COUNT) not allowed with WHERE   
-- SELECT COUNT(t3Fraction) AS Counter, t3Fraction, t3Date
--    FROM table3
--    WHERE Counter >= 2
--    GROUP BY t3Fraction;
   
SELECT COUNT(t3Fraction) AS Counter, t3Fraction, t3Date
   FROM table3
   GROUP BY t3Fraction
      HAVING Counter >= 2
   ORDER BY Counter;
      
DROP PROCEDURE IF EXISTS table1_Count;

DELIMITER //
CREATE
   DEFINER = CURRENT_USER
   PROCEDURE table1_Count (OUT countParm INT) 
   BEGIN
      SELECT COUNT(*) INTO countParm FROM table1;
   END//
   
DELIMITER ;
SHOW PROCEDURE STATUS WHERE db = 'classdemo';
CALL table1_Count (@parm1);
SELECT @parm1;
  
DROP FUNCTION IF EXISTS table2_Count;

DELIMITER //
CREATE
   DEFINER = CURRENT_USER
   FUNCTION table2_Count ()
   RETURNS INT DETERMINISTIC
   BEGIN
	  DECLARE temp INT;
	  SET temp = 0;
      SELECT COUNT(*) INTO temp FROM table2;
      RETURN temp;
   END//
   
DELIMITER ;
SHOW FUNCTION STATUS WHERE db = 'classdemo';
SELECT table2_Count();

SHOW TRIGGERS;

DROP TRIGGER IF EXISTS table1_INSERTAgeRange;

DELIMITER //

CREATE
   DEFINER = CURRENT_USER
   TRIGGER table1_INSERTAgeRange
   BEFORE INSERT
   ON table1 FOR EACH ROW
   BEGIN
      IF NEW.t1Age < 0 THEN
         SET NEW.t1Age = 0;
      END IF;   
   END
   //
   
DELIMITER ;
  
DROP TRIGGER IF EXISTS table1_UPDATEAgeRange;
DELIMITER //
CREATE
   DEFINER = CURRENT_USER
   TRIGGER table1_UPDATEAgeRange
   BEFORE UPDATE
   ON table1 FOR EACH ROW
   BEGIN
      IF NEW.t1Age < 0 THEN
         SET NEW.t1Age = 0;
      END IF;   
   END
   //
   
DELIMITER ;
INSERT INTO table1
       VALUES(10, 'lime green', -3, DEFAULT, 1);
UPDATE table1
   SET t1Age = 55
   WHERE t1Key = 10;
UPDATE table1
   SET t1Age = -5
   WHERE t1Key = 10;
   
DROP TABLE IF EXISTS table4;
CREATE TABLE table4 (
  t4Key INT AUTO_INCREMENT,
  t4Fraction FLOAT,
  t4Date Date DEFAULT '2019-02-20',
  PRIMARY KEY (t4Key));

INSERT INTO table4 (t4Fraction)
       VALUES(131.473);       
INSERT INTO table4 (t4Fraction, t4Date)
       VALUES(5001.32, '2019-07-19');       
INSERT INTO table4 (t4Fraction, t4Date)
       VALUES(7000, '2019-10-10');       

SELECT REPEAT('a',3) AS 'UNION Result'
   UNION
      SELECT REPEAT('b',10);
    
SELECT * 
   FROM table3
   UNION
   SELECT *
      FROM table4;
      
SELECT t3Date, t3Fraction
   FROM table3
   UNION
   SELECT t4Date, t4Fraction
      FROM table4;

*/