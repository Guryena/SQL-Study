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


CREATE TABLE dept(
deptno NUMBER(3) PRIMARY KEY,
dname VARCHAR2(10) UNIQUE,
loc VARCHAR2(10));

CREATE TABLE EMP(
empno NUMBER(3) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
deptno NUMBER(3),
job VARCHAR2(10),
sal NUMBER(10),
hiredate date default sysdate,
sex VARCHAR2(4) CHECK (sex = '남' OR sex = '여' OR sex = '남자' OR sex = '여자' ),
mgr NUMBER(3)
)

CREATE TABLE customer(
cno NUMBER(3) PRIMARY KEY,
cname VARCHAR2(10),
ctel VARCHAR2(20),
crrn VARCHAR2(14) UNIQUE,
cmgr NUMBER(3)
)

ALTER TABLE emp
ADD CONSTRAINTS deptno_FK FOREIGN KEY (deptno) 
REFERENCES dept(deptno);

ALTER TABLE customer
ADD CONSTRAINTS cmgr_FK FOREIGN KEY (cmgr)
REFERENCES emp(empno);

ALTER TABLE emp
ADD CONSTRAINTS mgr_FK FOREIGN KEY(mgr)
REFERENCES emp(empno);



Insert Into Dept Values(10, '총무부','서울');
Insert Into Dept Values(20, '영업부','대전');
Insert Into Dept Values(30, '전산부','부산');
Insert Into Dept Values(40, '관리부', '광주');

Insert Into emp Values(1,'홍길동',10,'회장',5000,'1980/01/01','남',null);
Insert Into emp Values(2,'한국남',20,'부장',3000,'1988/11/01', '남',1);
Insert Into emp Values(3,'이순신',20,'과장',3500,'1985/03/01','남', 2);
Insert Into emp Values(5,'이순라',20,'사원',1200,'1990/05/01','여', 3);
Insert Into emp Values(7,'놀기만',20,'과장',2300,'1996/06/01','여', 2);
Insert Into emp Values(11,'류별나',20,'과장',1600,'1989/12/01','여', 2);
Insert Into emp Values(14,'채시라',20,'사원',3400,'1993/10/01','여', 3);
Insert Into emp Values(17,'이성계',30,'부장',2803,'1984/05/01','남', 1);
Insert Into emp Values(13,'무궁화',10,'부장',3000,'1996/11/01','여', 1);
Insert Into emp Values(19,'임꺽정',20,'사원',2200,'1988/04/01','남', 7);
Insert Into emp Values(20,'깨똥이',10,'과장',4500,'1990/05/01','남', 13);
Insert Into emp Values(6,'공부만',30,'과장',4003,'1995/05/01','남', 17);
Insert Into emp Values(8,'채송화',30,'대리',1703,'1992/06/01','여', 17);
Insert Into emp Values(12,'류명한',10,'대리',1800,'1990/10/01','남', 20);
Insert Into emp Values(9,'무궁화',10,'사원',1100,'1984/08/01','여', 12);
Insert Into emp Values(4,'이미라',30,'대리',2503,'1983/04/01','여', 17);
Insert Into emp Values(10,'공부해',30,'사원',1303,'1988/11/01','남', 4);
Insert Into emp Values(15,'최진실',10,'사원',2000,'1991/04/01','여', 12);
Insert Into emp Values(16,'김유신',30,'사원',400,'1981/04/01','남', 4);
Insert Into emp Values(18,'강감찬',30,'사원',1003,'1986/07/01','남', 4);


insert into customer values(1,'류민', '123-1234', '700113-1537915',3);
insert into customer values(2,'강민', '343-1454', '690216-1627914',2);
insert into customer values(3,'영희', '144-1655', '750320-2636215',null);
insert into customer values(4,'철이', '673-1674', '770430-1234567',4);
insert into customer values(5,'류완', '123-1674', '720521-1123675',3);
insert into customer values(6,'캔디', '673-1764', '650725-2534566',null);
insert into customer values(7,'똘이', '176-7677', '630608-1648614',7);
insert into customer values(8,'쇠돌', '673-6774', '800804-1346574',9);
insert into customer values(9,'홍이', '767-1234', '731225-1234689',13);
insert into customer values(10,'안나','767-1677', '751015-2432168',4);



SELECT * FROM emp;
DESC emp;
--사원명, 급여, 월급, 세금(3.3%) 추출
--단, 월급은 십의자리에서 반올림, 세금은 일의자리까지 제한
SELECT ename AS "Name",
        sal AS "Annual salary",
        ROUND(sal/12, -2) AS "Salary",
        TRUNC(sal*0.033, -1) AS "Duty"
from emp;

--사원명, 급여, 급여현황(급여의 100단위 당 '*') 추출
SELECT ename AS "Name",
        sal AS "Salay",
        RPAD('*', TRUNC(sal/100, 0), '*') AS "Salary Status"
FROM emp;

desc customer;
--고객명, 전화번호, 주민등록번호1(ex.******-nnnnnnn), 주민번호2(ex.nnnnnn-*******)
SELECT cname AS "Customer Name",
        ctel AS "TEL",
    LPAD(
        SUBSTR(crrn, INSTR(crrn, '-')),
        LENGTH(crrn),
        '*') AS "*RRN",
    RPAD(
        SUBSTR(crrn, 1 , INSTR(crrn, '-')),
        LENGTH(crrn),
        '*') AS "RRN*"
FROM CUSTOMER;


--고객명, 전화번호, 성별 추출 (decode사용)
SELECT customer.cname AS "Name",
        customer.ctel AS "TEL",
        DECODE(
            SUBSTR(crrn, INSTR(crrn, '-')+1,1), 1, '남',
                                                2, '여') AS "SEX"
FROM customer;
--사원명, 급여, 보너스를 출력(case문)
--단, 보너스는 급여가 1000미만은 10%, 1000~2000은 15%, 2000초과는 20%, 없으면 0%
SELECT ename AS "Name",
        sal AS "Salary",
        CASE
            WHEN sal < 1000 THEN sal*0.1
            WHEN sal BETWEEN 1000 and 2000 THEN sal*0.15
            WHEN sal > 2000 THEN sal*0.2
            ELSE 0
        END AS "Incentive"
FROM emp;



SELECT sysdate, TO_CHAR(sysdate, 'am') FROM DUAL;


--현재 날짜를 [yyyy년 m월 d일 w요일] 형태로 추출
SELECT TO_CHAR(sysdate,
                'FM" "yyyy"年 "MM"月 "DD"日 "DAY"',
                'NLS_DATE_LANGUAGE=JAPANESE' ) AS "Now"
FROM DUAL;
SELECT TO_CHAR(sysdate, 
                'FM" "yyyy"year "Month" "MM" "DD" "DY"',
                'NLS_DATE_LANGUAGE=ENGLISH' ) AS "Now"
FROM DUAL;

SELECT ename AS "Name",
        sal AS "Salary",
        TO_CHAR(sal, 'FM9,990')
FROM emp
ORDER BY sal;

--INSERT INTO emp(ename, sal, empno) VALUES('john', 0, 999);
--DELETE FROM emp WHERE ename = 'john'; 

--사원명, 입사일, 근무기간(ex.yy년 mm개월) 추출
SELECT ename AS "Name",
        hiredate AS "Start date",
        EXTRACT(year from sysdate)-extract(year from hiredate)||'년'|| 
            ABS(EXTRACT(month from sysdate)-extract(month from hiredate))||'개월'
            AS "Period of Employment"
FROM emp;

--입사일 순서대로 석차추출(오름차순)
SELECT ename AS "Name",
        hiredate AS "Hiredate",
        RANK() OVER(order by hiredate) AS "Hiredate Rank"
FROM emp;

--부서별로 많이 받는 순의 급여 랭킹(오름차순)
SELECT dept.deptno AS "Department No.",
        dept.dname AS "Dept",
        emp.empno AS "Employee No.",
        emp.ename AS "Name",
        emp.sal AS "Salary",
        RANK() OVER(
            PARTITION BY dept.deptno 
            ORDER BY sal) AS "Rank"
FROM emp, dept
WHERE dept.deptno = emp.deptno
    AND emp.sal IS NOT NULL;


--직책별 인원수와 급여합계를 추출
SELECT dept.dname AS "Dept",
        COUNT(emp.ename) AS "Total members",
        SUM(NVL(emp.sal,0)) AS "Total Department Salary"
FROM dept, emp
WHERE dept.deptno = emp.deptno
GROUP BY dept.dname
ORDER BY "Total Department Salary";

--성별, 직책별로 평균 급여와 인원수를 출력하되, 사원과 대리 직책만 추출하되 인원수가 많은 순서대로 정렬
SELECT sex AS "Sex",
        job AS "Job",
        AVG(NVL(sal, 0)) AS "Average Salary",
        COUNT(*) AS "Count Member"
FROM emp
GROUP BY sex, job
HAVING job in ('사원', '대리')
ORDER BY sex, "Count Member";

--성별, 직책별로 평균 급여와 인원수를 출력하되, 사원을 제외하고, 집계 인원수가 2명 이하인 것만 추출
SELECT sex AS "Sex",
        job AS "Job",
        AVG(NVL(sal,0)) AS "Average Salary",
        COUNT(*) AS "Count Member"        
FROM emp
GROUP BY sex, job
HAVING job != '사원' AND COUNT(*) <= 2
ORDER BY "Sex", "Count Member";

--입사년도별로 평균급여를 추출
SELECT TO_CHAR(hiredate, 'yy.mm.dd') AS "Hiredate",
        AVG(NVL(sal, 0)) AS "Average Salary"
FROM emp
GROUP BY hiredate
ORDER By "Average Salary" DESC;


select rownum, emp.*
from 
        
emp;
--5명씩 평균급여 추출(ROWNUM 활용)
SELECT AVG(NVL(sal, 0)) AS "Average"
FROM emp
GROUP by CEIL(ROWNUM/5);


SELECT job AS "Job",
        sex AS "Sex",
        SUM(sal) AS "Total Salary"
FROM emp
GROUP BY ROLLUP(job, sex);


--직책별 인원수
SELECT
    COUNT(DECODE(job, '과장',0)) AS "과장",
        
FROM emp;

SELECT 
    job AS "Job",
    --SUM(DECODE(job, '과장', 
      --      DECODE(deptno, 10,sal)
        --    )) AS "Dept10"
    SUM(
        CASE
            deptno WHEN 10 THEN sal ELSE 0
        END) AS "Dept10",
    
    SUM(
        CASE
            deptno WHEN 20 THEN sal ELSE 0
        END) AS "Dept20",
    
    SUM(
        CASE
            deptno WHEN 30 THEN sal ELSE 0
        END) AS "Dept30",
       
    SUM(sal) AS "Total"

FROM emp
GROUP BY ROLLUP(job);


--이름의 길이가 6자 이상인 사원의 정보를 이름, 이름 글자수, 업무를 검색
SELECT ename AS "Name",
        LENGTH(ename) AS "NameSTR",
        job AS "Job"
FROM emp
WHERE LENGTH(ename) >=6;

--SCOTT의 사원번호, 성명(소문자로), 담당업무(대문자로) 검색
SELECT empno AS "EnpNO",
        LOWER(ename) AS "name",
        UPPER(job) AS "JOB"
FROM emp;

--DEPT 테이블에서 Loc 컬럼의 첫 글자만 대문자로 변환하여 검색
SELECT INITCAP(loc) AS "Location"
FROM dept;

--사원번호,이름,업무,급여를 검색하되 EMPNO와 ENAME을 줄 바꿔서 검색
SELECT ename AS "EmpNO",
        empno AS "Name",
        job AS "Job",
        sal AS "Sal"
FROM emp;

--이름의 첫 글자가 ‘K’보다 크고 ‘Y’보다 작은 사원의 정보 검색
SELECT ename AS "Name"
FROM emp
WHERE ename BETWEEN 'K%'  AND  'Y%';

--사원번호,이름,이름의 길이,급여,급여의 길이 검색
SELECT empno AS "EmpNO",
        ename AS "Name",
        LENGTH(ename) AS "Name Length",
        sal AS "Salary",
        LENGTH(sal) AS "Salary Length"
FROM emp;

-- 업무 중 ‘A’자의 위치를 검색, 두 번째 ‘A’자의 위치도 검색
SELECT INSTR(job, 'A') AS "Job1",
        INSTR(job, 'A', 1,2 ) AS "Job1"
FROM emp;


--이름의 검색 자릿수를 20으로 하고 오른쪽 빈칸에 ‘*’
SELECT RPAD(ename, 20,'*') AS "Name"
FROM emp;

--담당 업무 중 좌측에 ‘A’를 삭제하고 급여 중 좌측의 1을 삭제한 후 검색
SELECT LTRIM(job, 'A') AS "JOB",
        LTRIM(sal, 1) AS "Salary"
FROM emp;

--담당 업무 중 우측에 ‘T’를 삭제하고 급여 중 우측의 0을 삭제한 후 검색
SELECT RTRIM(job, 'T') AS "Job",
        RTRIM(sal,0) AS "Salary"
FROM emp;

--이름 중에 ‘A’,’B’,’C’는 소문자로 바꿔서 검색하고 급여를 숫자가 아닌 글자로 검색(급여가 1425 이면 일사이오)
--     Tip : translate() 이용

SELECT TRANSLATE(ename, 'ABC','abc') AS "Name",
        TO_CHAR(sal) AS "Sal"
FROM emp;

--JOB의 글자 중 ‘LE’를 ‘AL’로 바꿔서 검색
SELECT REPLACE(job, 'LE', 'AL') AS "Job"
FROM emp;

--모든 사원의 이름과 급여를 연결(||)하여 검색하되 각 15자리씩 왼쪽을 공백으로 검색
SELECT LPAD(ename, 15)||LPAD(sal, 15) AS "RAD"
FROM emp;

--숫자 1234.5678를 정수로 반올림하고 소수 첫째 자리까지 반올림과 절삭한 값을 검색
SELECT ROUND(1234.5678) AS "Integer",
        ROUND(1234.5678, 1) AS ".1",
        TRUNC(1234.5678, 1)
FROM dual;

--숫자 -456.789를 정수로 올림하고 -123.78을 내림한 정수를 검색
SELECT CEIL(-456.789),
        FLOOR(-123.78)
FROM dual;

--급여를 30으로 나눈 나머지를 구하여 검색
SELECT MOD(sal, 30)
FROM emp;

--모든 사원의 정보를 이름,업무,입사일, 입사한 요일을 검색
SELECT ename,
        job,
        hiredate,
        TO_CHAR(hiredate,'DAY')AS "hiredateWeek"
FROM emp;

--현재까지의 근무일수가 몇 주 몇 일인가 검색하라. 근무일수가 많은 사람순서로 검색하라.
--     (예:총 근무일수가 20일이면 2주 6일이 검색되게 한다.)
SELECT hiredate AS "My date",
    ABS(EXTRACT(month from sysdate)-extract(month from hiredate))*4||'week '|| 
            ABS(EXTRACT(day from sysdate)-extract(day from hiredate))||'day'
            AS "Period of Employment"
FROM emp;


--현재까지의 근무 월수를 계산하여 정수로 검색하라.
SELECT hiredate AS "My date",
    ABS(EXTRACT(month from sysdate)-extract(month from hiredate))||'Month'
            AS "Period of Employment"
FROM emp;


--입사일로부터 5개월이 지난 후 날짜를 ROUND 함수와 TRUNC함수를 이용하여 월을 기준으로 검색하라
SELECT ADD_MONTHS(hiredate, 5)
FROM emp;




COMMIT;
