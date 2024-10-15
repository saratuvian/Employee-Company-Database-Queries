sqlite> SELECT e.ename, e.city
   ...> FROM Employees e, Works w
   ...> WHERE e.ename = w.ename AND w.cname = 'bank israel';
dafna|tel aviv
david|jerusalem
yossi|jerusalem
sqlite> SELECT e.ename, e.city, e.street
   ...> FROM Employees e, Works w
   ...> WHERE e.ename = w.ename and  w.cname = 'bank israel' AND w.salary > 10000;
yossi|jerusalem|kg george
dafna|tel aviv|arlozorov
sqlite> SELECT e.ename
   ...> FROM Employees e, Works w, Companies c
   ...> WHERE e.ename = w.ename
   ...>   AND w.cname = c.cname
   ...>   AND e.city = c.city;
david
yoni
yossi
sqlite> SELECT e1.ename
   ...> FROM Employees e1
   ...> JOIN Manages m ON e1.ename = m.ename
   ...> JOIN Employees e2 ON m.mname = e2.ename
   ...> WHERE e1.city = e2.city AND e1.street = e2.street;
shimon
shoshana
sqlite> SELECT e.ename
   ...> FROM Employees e
   ...> WHERE e.ename NOT IN (
(x1...>     SELECT w.ename
(x1...>     FROM Works w
(x1...>     WHERE w.cname = 'bank israel'
(x1...> );
amir
anat
moshe
sara
shimon
shoshana
yoni
sqlite> SELECT e.ename
   ...> FROM Employees e
   ...> JOIN Works w ON e.ename = w.ename
   ...> WHERE w.salary > (SELECT MAX(salary) FROM Works WHERE cname = 'bank israel');
sqlite> SELECT e.ename, w.cname
   ...> FROM Employees e
   ...> JOIN Works w ON e.ename = w.ename
   ...> WHERE w.salary > (
(x1...>     SELECT AVG(salary)
(x1...>     FROM Works w2
(x1...>     WHERE w2.cname = w.cname
(x1...> );
yossi|bank israel
dafna|bank israel
anat|amdocs
sara|rad
amir|teva
sqlite> CREATE VIEW ManagersSalaries AS
   ...> SELECT DISTINCT e.ename, w.salary
   ...> FROM Employees e
   ...> JOIN Works w ON e.ename = w.ename
   ...> WHERE e.ename IN (
(x1...>     SELECT DISTINCT m.mname
(x1...>     FROM Manages m
(x1...> );
sqlite> SELECT w.cname, COUNT(w.ename) AS num_employees
   ...> FROM Works w
   ...> GROUP BY w.cname
   ...> ORDER BY num_employees DESC
   ...> FETCH FIRST 1 ROWS ONLY;
Parse error: near "FETCH": syntax error
  ks w GROUP BY w.cname ORDER BY num_employees DESC FETCH FIRST 1 ROWS ONLY;
                                      error here ---^
sqlite> SELECT w.cname, COUNT(w.ename) AS num_employees
   ...> FROM Works w
   ...> GROUP BY w.cname
   ...> HAVING COUNT(w.ename) = (
(x1...>     SELECT MAX(employee_count)
(x1...>     FROM (
(x2...>         SELECT COUNT(w2.ename) AS employee_count
(x2...>         FROM Works w2
(x2...>         GROUP BY w2.cname
(x2...>     ) AS subquery
(x1...> );
bank israel|3
sqlite>
