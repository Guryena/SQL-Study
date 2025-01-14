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
WHERE hiredate BETWEEN TO_TIMESTAMP('2024/01/14 00', 'yyyy/mm/dd')
                AND TO_TIMESTAMP('2025/01/15 00', 'yyyy/mm/dd');


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


--부서별로 정렬하되, 급여가 높은 순서대로 추출
SELECT NVL(deptno,0) AS "Name(if null, 0)", 
        ename AS "Name", 
        NVL(sal,0) AS "Salary(if null, 0)"
FROM emp
--WHERE sal IS NOT NULL OR deptno IS NOT NULL
ORDER BY deptno, sal DESC;


--1. emp table의 모든 열을 하나의 열로 출력하라.
-- (단, 각 열은 쉼표로 구분하며 표시하고, 열의 이름은 THE_OUTPUT으로 지정하라)
SELECT ename ||','||comm||','||mgr||','
        ||hiredate||','||sal||','
        ||comm||','||deptno
        AS "THE_OUTPUT"
FROM emp;
--2. 급여가 1500 ~ 2850 사이의 범위에 속하지 않는 모든 사원의 이름 및 급여를 표시하라.
SELECT ename AS "Name", sal AS "Salary"
FROM emp
WHERE sal NOT BETWEEN 1500 AND 2850;
--3. 1981년 2월 20일 ~ 1981년 5월 1일에 입사한 사원의 이름, 직위 및 입사일을 표시하라.
-- (입사일을 기준으로 오름차순 정렬할 것!)
SELECT ename AS "Name", 
        job AS "Job", 
        hiredate AS "Hiredate"
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/02/20', 'yyyy/mm/dd')
                AND TO_DATE('1981/05/02', 'yyyy/mm/dd')
ORDER BY hiredate;


--4. 부서가 10, 30에 속하는 사원 중 급여가 1500을 넘는 사원의 이름 및 급여를 표시하라.
SELECT ename AS "Name",
        sal AS "Salary"
FROM emp
WHERE deptno IN (10, 30) AND sal > 1500;
--5. 1982년에 입사한 모든 사원의 이름과 입사일을 표시하라.
SELECT ename AS "Name",
        hiredate AS "HireYear"
FROM emp
WHERE extract(year from hiredate) = '1982';
--6. 이름에 L이 두 번 들어가며 부서 30에 속하거나 관리자 번호가 7782인 
--모든 사원의 이름을 표시하라.
SELECT deptno, ename, mgr
FROM emp
WHERE ename like '%L%L%'
    AND (deptno = 30 OR mgr = 7782);
--7. 직위가 CLEEK, ANALYST 이면서 급여가 1000, 3000, 5000가 아닌
--모든 사원의 이름, 직위 및 급여를 표시하라.
SELECT ename, job, sal
FROM emp
WHERE job IN ('CLERK', 'ANALYST') AND sal NOT IN (1000, 3000, 5000);


--8. 사원 번호, 이름, 급여 및 15% 인상된 급여를 정수로 표시하고
--열 레이블(별칭)을 NEW SALARY로 하라.
SELECT empno,
        ename AS "Name",
        sal,
        FLOOR(sal * 1.15) AS "NEW SALARY"
FROM emp;
--9. 8번 문제에 인상분만을 표시하는 열을 추가하여 쿼리하고, 열 이름을 INCREASE 로 하라.
SELECT empno,
        ename AS "Name",
        sal,
        FLOOR(sal * 1.15) AS "NEW SALARY",
        sal*0.15 AS "INCREASE"        
FROM emp;
--10. 사원 이름 및 커미션을 표시하는 질의를 작성한다.
--    커미션을 받지 않는 사원일 경우 ‘No Commision’을 표시하고 열 이름을 COMM으로 지정한다
SELECT ename, NVL(TO_CHAR(comm),'No Commision' ) AS "COMM"
FROM emp;
--11. 이름에 L이 두번만 포함하는 사람을 추출-instr함수 이용해 볼 것.
SELECT ename
FROM emp
WHERE INSTR(ename, 'LL') > 0;
commit;