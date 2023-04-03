USE adventureworks;

-- Сумма по кварталам
SELECT COUNT(*) AS Orders,
       CONCAT(YEAR(s.OrderDate), '-', QUARTER(s.OrderDate)) AS YearQuarter,
       FORMAT(SUM(s.SubTotal), 0) AS SubTotal,
       FORMAT(SUM(s.TaxAmt), 0) AS TaxAmt,
       FORMAT(SUM(s.Freight), 0) AS Freight,
       FORMAT(SUM(s.TotalDue), 0) AS TotalDue
  FROM adventureworks.salesorderheader s
 GROUP BY YearQuarter WITH ROLLUP
 ORDER BY YearQuarter IS NULL ASC;

-- Отчет по неделям за последний месяц года
SELECT COUNT(*) AS Orders,
       YEAR(s.OrderDate) AS Year,
       WEEK(s.OrderDate) AS Week,
       MIN(s.TotalDue) AS Min,
       MAX(s.TotalDue) AS Max,
       AVG(s.TotalDue) AS Avg,
       sum(s.TotalDue) AS Total,
       (case WHEN sum(s.TotalDue) > 30000
             THEN 'Completed' ELSE 'Bad' END) as Plan
  FROM adventureworks.salesorderheader s
 WHERE s.OrderDate BETWEEN '2001-12-01' AND '2001-12-31'
 GROUP BY YEAR(s.OrderDate), WEEK(s.OrderDate)
HAVING Avg > 3500
   AND Orders <= 50;

-- Отчет по территориям по месяцам за год с максимальной и минимальной ценами и количеством предложений,
-- с группировкой по годам и месяцам
SELECT s.TerritoryID AS Territory,
       YEAR(s.OrderDate) AS Year,
       MONTH(s.OrderDate) AS Month,
       MIN(s.SubTotal) AS Min,
       MAX(s.SubTotal) AS Max,
       COUNT(*) As Orders
  FROM adventureworks.salesorderheader s
 WHERE YEAR(s.OrderDate) = 2002
   AND s.TerritoryID IN (3, 7)
 GROUP BY Territory, Year, Month WITH ROLLUP
HAVING COUNT(*) >= 10
 ORDER BY Territory, Year, Month;
