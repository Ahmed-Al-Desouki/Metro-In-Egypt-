-- 1
-- retrieve all details about person.
SELECT *
FROM
    person;
-- 2 -----
    -- retrieve ticket code and date.
SELECT 
    code, date
FROM
    access_method
WHERE
    date IS NOT NULL;
-- 3 -----
    -- retrieve train code and it's enargy that's in line 1.
SELECT 
    code, energy
FROM
    train
WHERE
    LNumber = 1;
-- 4 -----
-- retrieve station name where location is cairo ;
SELECT 
    name
FROM
    station
WHERE
    Location = 'cairo';
-- 5 -----
-- retrieve all details about station where station name contain the character'sh'. 
SELECT 
    *
FROM
    station
WHERE
    Name LIKE '%sh%';
-- 6 -----
-- retrieve first name , ssn and address of all person that he's address contain characters 'mahdi'.
SELECT 
    ssn, fname, address
FROM
    person
WHERE
    address LIKE '%mahdi%';
-- 7 -----
   -- retreve the name , ssn and phone of person who have WE number '015' 
SELECT 
    ssn, fname, phone
FROM
    person
WHERE
    phone LIKE '015%';
-- 8 -----
-- retrieve the salary of empolyee that it contains a Fractions. 
SELECT 
    salary
FROM
    employee
WHERE
    salary LIKE '%.%';  
 -- 9 -----
-- retrieve first name and number of persons that first character of his name is 'a' or secend character is 'a' for each name. 
SELECT 
    fname, COUNT(*) as "number of person"
FROM
    person
GROUP BY fname
having
    fname LIKE 'a%' OR fname LIKE '_a%';
-- 10 -----
-- retrieve all salarys of empolyee that's not between 5000 and 8000.
SELECT 
    salary
FROM
    employee
WHERE
    salary NOT BETWEEN 5000 AND 8000;
-- 11 -----
-- retrieve first name , last name and salary of all empolyees whose salary between 5000 and 9000.
SELECT 
    d.fname, d.lname, e.salary
FROM
    employee e,
    person d
WHERE
    salary BETWEEN 5000 AND 9000
        AND e.pssn = d.ssn;
-- 12 -----
    -- retrieve first name and sex of ticket workers.
SELECT 
    p.fname, p.sex
FROM
    person p
        JOIN
    ticket_worker t ON p.ssn = t.pssn
ORDER BY p.sex;
-- 13 -----
-- retrivere all details of accident and show the time of each accident ordered desc.
SELECT 
    *
FROM
    Accident d,
    occurs e
WHERE
    d.num = e.anum
ORDER BY time DESC;
-- 14 -----
-- retrieve all passenger that access-method is a card.
SELECT 
  pssn ,  t.*
FROM
    Passenger p
        JOIN
    access_method T ON p.code = T.code
WHERE
    cflag = 1;
-- 15 -----
-- retrivere all train that didn't make an accident.
SELECT 
    d.code
FROM
    train d,
    occurs p
WHERE
    d.code <> p.trcode;  
-- 16 -----
    -- retrieve all train that make an accident.
SELECT 
    d.code
FROM
    train d,
    occurs p
WHERE
    d.code = p.trcode;
-- 17 -----
    -- retrieve the name , salary and salary after adding 10% interest of the empolyees. 
SELECT 
    fname, lname, (0.1 * salary) + salary AS inc_sal, salary
FROM
    person
        JOIN
    employee ON pssn = ssn;
-- 18 -----
-- add column relatonship to dependent with type varchar.
alter table dependent 
add relationship varchar(20) not null ; 
-- 19 -----
-- change column relationship where name is ashraf such that it's relationship be son.
UPDATE dependent 
SET 
    relationship = 'son'
WHERE
    (name = 'ashraf')
        AND (Pssn = '3111143747');
-- 20 -----
 -- change column relationship where name is ayyat such that it's relationship be wife.
UPDATE dependent 
SET 
    relationship = 'wife'
WHERE
    (name = 'ayaat')
        AND (Pssn = '2111137605');       
-- 21 -----
-- change column relationship where name is nade such that it's relationship be mother.
UPDATE dependent 
SET 
    relationship = 'mother'
WHERE
    (name = 'nade')
        AND (Pssn = '1911142470');
-- 22 -----
-- change the access method from ticket to card and it's price is 38 , where code of ticket is 6189.
UPDATE access_method 
SET 
    name = 'card',
    price = 38
WHERE
    code= 6189; 
-- 23 -----
-- retrieve dependant name of employees.
SELECT 
    e.name
FROM
    dependent e,
    employee d
WHERE
    d.pssn = e.pssn;
-- 24 -----
-- retrieve first name , last name and salary grater than or equal 5000 from mangers. 
SELECT 
    p.fname, p.lname, e.salary
FROM
    person p
        JOIN
    employee e ON p.ssn = e.pssn
        JOIN
    manger m ON p.ssn = m.pssn
WHERE
    salary >= '5000';
-- 25 -----
-- retrieve station names and it's line number.
SELECT 
    s.name, l.number
FROM
    station s,
    line l,
    l_has h
WHERE
    s.name = h.sname
        AND h.LNumber = l.Number;
-- 26 -----
-- retrieve the stations name that Connects two lines. 
SELECT DISTINCT
    t.sname, t.in_lnumber 'in_line', t.out_lnumber 'out_line'
FROM
    station s,
    transform t,
    line l
WHERE
    s.name = t.sname
        AND l.number = t.in_lnumber
        OR l.number = t.out_lnumber;
-- 27 -----
-- retrieve the station name and ssn of subscription_worker who work in this station.
SELECT 
    pssn, p.fname, p.lname, name
FROM
    station s
        JOIN
    subscription_worker w ON name = sname
        JOIN
    person p ON ssn = pssn;
-- 28 -----
-- retrivere name , pssn , ticket code and date where the ticket type is green.
SELECT 
    ps.pssn, p.fname, p.lname, b.tcode, date
FROM
    person AS p
        JOIN
    passenger AS ps ON p.ssn = ps.pssn
        JOIN
    buy AS b ON b.pssn = ps.pssn AND type = 'green'
        JOIN
    access_method AS c ON b.tcode = c.code;
-- 29 ------
-- retrieve name and ssn for person that didnt work like manger , employee , ticet-worcker and subscription-worker.
SELECT 
    e.pssn, p.fname
FROM
    person AS p
        JOIN
    employee AS e ON e.pssn = p.ssn
        LEFT outer JOIN
    manger AS m ON m.pssn = e.pssn
        LEFT outer JOIN
    ticket_worker AS t ON t.pssn = e.pssn
        LEFT outer JOIN
    subscription_worker AS s ON s.pssn = e.pssn
WHERE
    m.pssn IS NULL AND t.pssn IS NULL
        AND s.pssn IS NULL;
-- 30 -----
--  retrieve employee name that supply a safety services for the train.     
SELECT 
    fname
FROM
    employee AS e
        JOIN
    supply AS s ON e.pssn = s.pssn
        JOIN
    train AS t ON t.code = s.trcode
        JOIN
    safety_services AS f ON f.ssnumber = s.safety_number
        JOIN
    person p ON e.pssn = p.ssn;
-- 31 -----
-- retrieve the name of employee and station  , train code , safety services types , time and number of an accident.
SELECT 
    p.fname,
    p.lname,
    sname 'staition',
    t.code 'train code',
    v.type 'kind of safaty',
    o.time 'accident time',
    a.num 'accident number'
FROM
    person p
        JOIN
    employee e ON p.ssn = e.pssn
        JOIN
    supply s ON e.pssn = s.pssn
        JOIN
    train t ON s.trcode = t.code
        JOIN
    occurs o ON t.code = o.trcode
        JOIN
    accident a ON o.ANum = a.num,
    safety_services v,
    station st
WHERE
    s.Safety_Number = v.SsNumber
        AND st.name = e.sname
ORDER BY a.num;
-- 32 -----
-- retrieve the name of passengers, ticket type ,price ,code and date who went to sadat station.  
SELECT 
    p.fname,
    p.lname,
    b.type,
    a.price,
    c.acode 'ticket code',
    a.date
FROM
    person p
        JOIN
    passenger pa ON p.ssn = pa.pssn
        JOIN
    buy b ON pa.pssn = b.pssn
        JOIN
    access_method a ON b.tcode = a.code
        JOIN
    crosss c ON a.code = c.acode
        JOIN
    station s ON c.sname = s.name
WHERE
    c.End_station = 'sadat';
-- 33 -----
-- retrieve the name , birth date and the age ordered desc of the person . 
SELECT 
    fname , lname , bdate, TIMESTAMPDIFF(YEAR, bdate, CURDATE()) AS age
FROM
    person
ORDER BY 4 DESC;
-- 34 -----
-- retrieve sex and number for each dependant of employee. 
SELECT 
    sex, COUNT(*) "number of dependent"
FROM
    dependent
GROUP BY sex
having
    sex IN ('f' , 'm');
-- 35 -----
-- retrieve the maximum and minimum of salary of employees.
SELECT 
    MAX(salary), MIN(salary)
FROM
    employee;
-- 36 -----
-- retrieve count of all salayrs that empolyees have , sumation of all salarys and average of salarys.
SELECT 
    COUNT(salary) AS counts,
    SUM(salary) AS 'sum of salary',
    AVG(salary) AS "Average Salary"
FROM
    employee;
-- 37 -----
-- retrieve first name , ssn , last name and salary from employee where salary grater than average of salary of each name ordered.
  SELECT 
        e.pssn, p.fname, p.lname, e.salary
    FROM
        person p JOIN employee e 
        
        ON p.ssn = e.pssn
    WHERE
        e.salary > (SELECT AVG(salary)
        
            FROM employee)
            
    ORDER BY fname;
-- 38 -----
-- retrieve the name and ssn of empolyees and manager where they work is staition nasser.
SELECT 
    ssn,fname, lname 
FROM
    employee AS e,
    person AS p,
    manger AS m,
    station AS n
WHERE
    e.pssn = p.ssn AND m.pssn = p.ssn
        AND n.name = (SELECT name
        FROM
            station AS n
        WHERE
            n.name = 'nasser');
-- 39 -----
-- retrieve all details from empolyee who works minimum of hours .
SELECT 
    *
FROM
    Employee
WHERE
    hours = (SELECT 
            MIN(hours)
        FROM
            Employee);
-- 40 -----
-- retrieve the names of employees who work with a specific manager.
SELECT 
    fname, lname, ssn, salary, name
FROM
    person,
    employee,
    station
WHERE
    pssn = ssn AND sname = name
        AND mpssn IN (SELECT 
            pssn
        FROM
            station,
            manger
        WHERE
            mpssn = pssn AND pssn = '4111113930');