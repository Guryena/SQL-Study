select * from emp;
select empno, ename, mgr from emp;
select * from tab;
desc emp;

select empno AS "사원번호", ename, job, hiredate, sal, DEPTNO 
    from EMP 
    WHERE DEPTNO = 10 
        AND mgr IS NOT NULL;
--
SELECT ename AS "name", sal AS "salary"
    FROM emp
    WHERE sal NOT BETWEEN 1000 AND 2000;
    --WHERE sal >= 1000 AND sal <=2000;
--
SELECT INITCAP(ename) AS "Name", job AS "Job"
    FROM emp
--    WHERE LOWER(job) in ('salesman', 'clerk')
    WHERE LOWER(job) like 'salesman'
        OR LOWER(job) like 'clerk'
    ORDER BY job;
DESC EMP;


INSERT INTO emp(empno, ename, hiredate) VALUEs(101, 'JOHN', sysdate);
--delete from emp where ename='JOHN';


--alter table emp modify hiredate timestamp;

--입사일이 '87/01/01~'24/01/14 인사람 추출
SELECT ename AS "Name", hiredate AS "Hiredate"
FROM emp
WHERE hiredate BETWEEN TO_DATE('1987/01/01', 'yyyy/mm/dd') 
                AND TO_DATE('2025/01/15', 'yyyy/mm/dd');


select extract(year from hiredate) from emp;



--입사일이 '24/01/14 자정~오후 6시까지인 사람 추출
SELECT ename AS "Name", hiredate AS "Hiredate"
FROM emp
WHERE hiredate BETWEEN TO_TIMESTAMP('2024/01/14 00', 'yyyy/mm/dd am hh')
                AND TO_TIMESTAMP('2025/01/15 00', 'yyyy/mm/dd am hh');


SELECT ename, comm
from emp
where comm is null;

SELECT ename AS "Name", job AS "Job", sal AS "Basic Salary",
    NVL(comm,0) AS "Commission", sal + NVL(comm,0) AS "Actual Salary"
FROM emp
WHERE sal IS NOT NULL;


SELECT ename||'''s job is ' ||job AS "result"
FROM emp;

------------------------
SELECT ename AS "Name"
FROM emp
WHERE ename like 'A%';

SELECT ename AS "Name"
FROM emp
WHERE ename like '%L%';

SELECT ename AS "Name"
FROM emp
WHERE ename like '_L%';

SELECT ename AS "Name"
FROM emp
WHERE ename like '%L%L%';

--------------------
--중복제거
SELECT DISTINCT job from emp;
select ename from emp

--검색하고 싶은 문자 패턴은 'A#' 일 경우 
-- '#' 가 escape 식별자가 되면서 '#' 뒤의 '_' 가 문자 그대로 해석
where ename like 'A#_%' escape '#';




commit;