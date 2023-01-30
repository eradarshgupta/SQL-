create database  project;
use project;

create table Employee (
empno int not null primary key,
ename varchar(20) not null,
job varchar(15) not null default 'CLERK',
mgr int, 
hiredate date not null,
sal decimal	(8,2) not null check (sal>=0),
comm decimal (6,2),
deptno int not null,
foreign key (deptno) references Dept(deptno)
);

drop table Employee;
desc Employee;

insert into Employee values (7369,'SMITH','CLERK',7902,'1890-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',3000.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

create table dept(deptno int primary key, dname varchar(30), ioc varchar(30));
desc dept;
insert into Dept values (10,'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');

select * from employee;
select * from dept;

-- Q3
Select ename,sal from employee where sal>1000;

-- Q4
select * from employee where hiredate<='1981-09-30';

-- Q5
select ename from employee where ename like '_i%';

-- Q6
select ename as 'Employee Name'
, sal as 'Salary'
,sal*(40/100) as 'Allowances'
,sal*(10/100) as 'P.F.'
,sal+sal*(40/100)+sal*(10/100) as 'Net Salary' from employee;

-- Q7
select *
from employee
where mgr is null;

-- Q8
select empno, ename, sal 
from employee
order by sal asc;

-- Q9
select count(distinct job)
from employee;

-- Q10
select sum(sal) as 'Total_Paybale_salary' 
from employee
where job = 'salesman';

-- Q11 11.	List average monthly salary for each job within each department   
select Employee.job, Dept.dname,dept.deptno, avg(Employee.sal) as monthly_average_salary
from Dept
join Employee
on Dept.deptno = Employee.deptno
group by Employee.job,Dept.dname;


-- Q12 12.	Use the Same EMP and DEPT table used 
-- in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
select employee.ename as EMPNAME, employee.sal as SALARY, dept.dname as DEPTNAME
from Dept
join Employee
on Dept.deptno=Employee.deptno;

-- Q13
create table job_grades_table ( grade varchar(1) not null, lowest_sal int not null, highest_sal int not null); 
insert into job_grades_table values ('A',0,999),('B',1000,1999),('C',2000,2999),('D',3000,3999),('E',4000,5000);
select * from job_grades_table;

-- Q14
select employee.ename, employee.sal, job_grades_table.grade 
from employee
inner join job_grades_table
on employee.sal between job_grades_table.lowest_sal and job_grades_table.highest_sal;

-- Q15
select CONCAT(e1.ename, ' Report to ', e2.ename) as 'Emp Report to Mgr' 
from Employee e1 
inner join Employee e2 
on e1.mgr = e2.empno;

-- Q16
select ename, (sal + ifnull(comm,0)) as Total_sal
from employee;

-- Q17
select ename, sal 
from employee
where mod(empno,2) = 1;

-- Q18

SELECT e.ename, 
       (SELECT COUNT(*) 
        FROM Employee 
        WHERE sal > e.sal) + 1 AS rank_of_sal,
        d2.dname,
       (SELECT COUNT(*) 
        FROM Employee AS e2 
        JOIN Dept AS d ON e2.deptno = d.deptno 
        WHERE d.dname = d2.dname 
        AND e2.sal > e.sal) + 1 AS rank_of_sal_in_dname 
FROM Employee AS e 
JOIN Dept AS d2 ON e.deptno = d2.deptno
order by rank_of_sal asc;

-- Q19
select ename as Top_3_Employees, sal as Salary
from Employee
order by sal desc limit 3;

-- Q20
select e.ename, g.highest_sal, d.dname
from Employee 
join Dept d on e.deptno=d.deptno
join job_grades_table g on e.sal between g.lowest_sal and g.highest_sal
where e.sal = (select MAX(sal) from Employee e where e.deptno=d.deptno)
group by d.dname;


