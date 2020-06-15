-- 1
SELECT t1Color, t1Tree
   FROM table1;
   
-- 2
SELECT t1.t1Color, t1.t1Tree
   FROM table1 AS t1;
   
-- 3
SELECT t1.t1Color, t1.t1Tree
   FROM table1 AS t1
   ORDER BY t1Color DESC;
   
-- 4
SELECT DISTINCT t1Tree
   FROM table1;
   
-- 5
SELECT t1.t1Color, t2.t2Color
   FROM table1 AS t1, table2 AS t2;
   
-- 6
SELECT t3Fraction
   FROM table3;

-- 7
SELECT COUNT(t3Fraction)
   FROM table3;

-- 8   
SELECT t3Fraction, COUNT(t3Fraction)
   FROM table3
   GROUP BY t3Fraction;
   
 -- 9
SELECT AVG(t3Fraction) AS 'Average of t3Fraction'
   FROM table3;
  
-- 10
SELECT t1.t1Color, t2.t2Color
   FROM table1 AS t1, table2 AS t2
   WHERE t2.t1key = t1.t1Key;
   
-- 11
SELECT t1.t1Color, t2.t2Color
   FROM table1 AS t1, table2 AS t2
   WHERE t2.t1key = t1.t1Key AND
         (t1Color = 'GREEN' OR t2Color = 'BLUE');
   
   

   
   