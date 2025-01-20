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
    COUNT(DECODE(job, '과장',0)) AS "과장"
        
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
SELECT TRUNC(ADD_MONTHS(hiredate, 5), 'mm'), ROUND(ADD_MONTHS(hiredate, 5), 'mm')
FROM emp;

--입사일자로부터 돌아오는 금요일을 검색하라
SELECT NEXT_DAY(hiredate, 6) AS "Next Friday"
FROM emp;

--입사한 달의 근무일수를 계산하여 검색하라, 단 토/일요일도 근무일수에 포함한다.
SELECT LAST_DAY(hiredate)-hiredate AS "WORKDAYS"
FROM emp;

--입사날짜를 ‘1 Jan 1981’ 과 ‘1981년 01월 01일’의 형태로 검색하라.
SELECT TO_CHAR(hiredate, 
                'FM""dd" "mon" "yyyy"',
                'NLS_DATE_LANGUAGE=ENGLISH') AS "ENG date",
       TO_CHAR(hiredate,
                '""yyyy"년 "mm"월 "dd"일') AS "KOR date"
FROM emp;



--입사일이 February 20, 1981과 May 1, 1981 사이에 입사한 사원의 이름,업무,입사일을 검색. 
SELECT ename AS "Name",
        job As "Job",
        hiredate AS "Hiredate"
FROM emp
WHERE hiredate BETWEEN '81/02/20' AND '81/05/01';

--위의 문제를 현재 세션을 February 20, 1981에 맞게 변경한 후에 검색하라.
SELECT ename AS "Name",
        job As "Job",
        TO_CHAR(hiredate, 
                'FM""Month" "dd" "yyyy"',
                'NLS_DATE_LANGUAGE=ENGLISH') AS "Hiredate"
FROM emp
WHERE hiredate BETWEEN '81/02/20' AND '81/05/01';


--연봉에 보너스를 합한 금액을 $를 삽입하고 3자리마다 ,를 검색하라.
SELECT TO_CHAR(sal+NVL(comm, 0), '$999,999') AS "Total Salary"
FROM emp;


--JOB이 ANALYST 이면 수당으로 급여의 10%를 지급하고 
--CLERK 이면 급여의 15% 지급, MANAGER이면 20% 지급하려고 한다. 
--다른 업무는 보너스가 없다. 사원번호, 이름, 업무, 급여, 수당을 검색하라. (CASE문)
SELECT empno AS "No",
        ename AS "Name",
        job AS "Job",
        sal AS "Salary",
        CASE
            WHEN job = UPPER('ANALYST') THEN sal * 0.1
            WHEN job = UPPER('CLERK') THEN sal * 0.15
            WHEN job = UPPER('MANAGER') THEN sal * 0.2
            ELSE 0
        END AS "Incentive"
FROM emp;


-- 위 문제를 DECODE를 사용하여 검색하라
SELECT empno AS "No",
        ename AS "Name",
        job AS "Job",
        sal AS "Salary",
        DECODE ( job, UPPER('ANALYST'), sal * 0.1,
                    UPPER('CLERK'), sal * 0.15,
                    UPPER('MANAGER'), sal * 0.2,
                    0) AS "Incentive"
FROM emp;


--급여가 1000 이상 2000 이하이면 1500을 지급하고 그 외에는 800을 지급하라
SELECT ename AS "Name",
        sal AS "Salary",
        CASE
            WHEN sal BETWEEN 1000 AND 2000 THEN 1500
            ELSE 800
        END AS "Incentive"
FROM emp;


--현재 급여를 기준으로 입사한 달의 근무일수에 해당하는 급여를 산출하라. (일일 급여액 = 연 급여액/365)
SELECT ename AS "Name",
        
        (LAST_DAY(hiredate) - hiredate) * (sal / 365) 
        AS "First Salary"
FROM emp;















-- EMP테이블에서 모든 SALESMAN에 대하여 
-- 급여의 평균, 최고액, 최저액, 합계를 구하여 출력하라.
SELECT AVG(NVL(sal, 0)) AS "Average",
        MAX(sal) AS "Max",
        MIN(sal) AS "Min",
        SUM(NVL(sal, 0)) AS "Sum"
FROM emp;

--EMP 테이블에 등록되어 있는 인원수,COMM의 합계,전체 사원의 COMM 평균,
--등록되어 있는 부서의 수를 구하여 출력하라.
SELECT COUNT(*) AS "Count",
        SUM(NVL(comm, 0)) AS "Sum Commision",
        AVG(NVL(comm, 0)) AS "Average Commision",
        COUNT(DISTINCT deptno) AS "Count Department"
FROM emp;

-- 부서별로 인원수, 평균급여, 최저 급여, 최고 급여를 구하여라.
SELECT deptno AS "Department No.",
        COUNT(empno) AS "Count Employee in Department",
        AVG(sal) AS "Average Salary in Department",
        MIN(sal) AS "Minimum Salary in Department",
        MAX(sal) AS "Maximun Salary in Department"
FROM emp
GROUP BY deptno;


--상기 문제에서 최대 급여가 3000 이상인 부서별로 출력하라.
SELECT deptno AS "Department No.",
        COUNT(empno) AS "Count Employee in Department",
        AVG(sal) AS "Average Salary in Department",
        MIN(sal) AS "Minimum Salary in Department",
        MAX(sal) AS "Maximun Salary in Department"
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

--10번과 30번 부서에서 업무별 최소급여가 1500 이하인 업무와 최소급여를 출력하라.
SELECT deptno AS "Department No.",
        job AS "Job",
        MIN(sal) AS "Minimum Salary"
FROM emp
GROUP BY job, deptno
HAVING deptno IN(10, 30)
ORDER BY "Department No.", "Minimum Salary";

--부서별 인원이 4명 이상인 부서별 인원수, 급여의 합을 출력하라.
SELECT deptno AS "Department",
        COUNT(*) AS "Count Employee",
        SUM(sal) AS "Total Salary"
FROM emp
GROUP BY deptno
HAVING COUNT(*)>=4;

--전체 급여가 5000을 초과하는 각 업무에 대해 업무와 급여 합계를 출력하라.
--단, SALESMAN은 제외하고 급여 합계를 내림차순으로 정렬하라.
SELECT job AS "Job",
        SUM(sal) AS "Total Salary"
FROM emp
GROUP BY job
HAVING SUM(sal) > 5000 
    AND job != UPPER('SALESMAN');

--부서별 평균 중 최대평균급여, 부서별 급여의 합 중 최대급여, 
--전체 급여에서 최소 급여, 전체 급여 에서 최대 급여를 출력하라.
SELECT deptno AS "Department",
        SUM(sal),
        MAX(AVG(NVL(sal,0))) AS "MAX of AVG Sal in Dept",
        MAX(SUM(sal)) AS "MAX of Total Sal in Dept",
        MIN(SUM(sal)) AS "MIN of SUM Salary",
        MAX(SUM(sal)) AS "Total of MAX Salary"
FROM emp
GROUP BY deptno, sal) ;


--부서별 업무별 급여의 평균을 출력하는 SELECT문장을 작성하라. (세자리 구분기호)
SELECT job AS "Job",
        TO_CHAR(AVG(DECODE(
                    deptno, 10 ,NVL(sal,0))), '999,999') AS "deptNO 10",
        TO_CHAR(AVG(DECODE(
                    deptno, 20 ,NVL(sal,0))), '999,999') AS "deptNO 20",
        TO_CHAR(AVG(DECODE(
                    deptno, 30 ,NVL(sal,0))), '999,999') AS "deptNO 30",
        TO_CHAR(AVG(NVL(sal, 0)), '999,999') AS "Total"
FROM emp
GROUP BY job
ORDER BY job;

--급여가 1000 이하인 인원수,1001에서 2000 사이의 인원수,2001에서
--3000 사이의 인원수,3000 초과인 인원수를 출력하시오.
SELECT COUNT(
            CASE
                WHEN sal > 3000 THEN empno
                
            END) AS "3000 초과",
      COUNT  (
            CASE
                WHEN sal BETWEEN 2001 and 3000 THEN empno
                
            END) AS "3000~2001",
      COUNT  (
            CASE
                WHEN sal BETWEEN 1001 and 2000 THEN empno
                
            END) AS "1001~2000",
      COUNT  (
            CASE
                WHEN sal <= 1000 THEN empno
                
            END) AS "1000이"
FROM emp;

--부서별 급여평균과 업무별 급여평균과 매니저별 급여 평균을 출력.(Grouping sets를 이용)
SELECT deptno AS "Dept No.",
        job AS "Job",
        mgr AS "Manager",
        AVG(NVL(sal, 0)) AS "Average Salary"
        
FROM emp
GROUP BY GROUPING SETS(deptno, job, mgr);


--부서와 업무의 그룹별 인원 수와 부서와 매니저의 그룹별 인원수를 함께 출력.(Grouping sets 이용)
SELECT deptno AS "Dept",
        job As "Job",
        mgr AS "Mgr",
        COUNT(*)
FROM emp
GROUP BY GROUPING SETS((deptno, job), (job, mgr));

--업무와 부서별 급여의 합과 평균을 출력하고 업무별 급여 합과 평균을 함께 출력(Grouping sets 이용)
SELECT job AS "Job",
        deptno AS "Dept",
        SUM(sal) AS "Total",
        AVG(NVL(sal,0)) AS "Average"
FROM emp
GROUP BY GROUPING SETS((job, deptno),job );

--전체합계, 부서별 합계, 업무별 합계,업무별 부서별 합계 순서로 출력하라.
SELECT deptno AS "Dept",
        job AS "Job",
        SUM(sal) AS "Total"
FROM emp
GROUP BY GROUPING SETS(deptno, job,(deptno, job), ());



--부서별 매니저별 합계, 부서별 합계, 전체 합계 순서로 출력하라.
SELECT deptno,
        mgr,
        SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, mgr)
ORDER BY mgr is null, mgr;

--직위가 동일한 사람의 수를 표시하는 질의를 작성한다.
SELECT job AS "Job",
        COUNT(job) AS "Count same job"
FROM emp
GROUP BY job
HAVING COUNT(job)>1;

--관리자 목록 없이 관리자 수만 표시하고 열 이름을 Number Of Managers로 지정한다
SELECT COUNT(mgr) AS "Number Of Managers"
FROM emp
GROUP BY mgr;









--EMP 테이블과 DEPT 테이블을
--CARTESIAN PRODUCT로 사원번호,이름,업무,부서번호,부서명,근무지를 출력하라.
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.job AS "Job",
        d.deptno AS "DEPT No.",
        d.dname AS "DEPT Name",
        d.loc AS "Location"
FROM emp e, dept d;

--EMP 테이블에서 사원번호, 이름 ,업무, 부서번호,부서명,근무지 출력하라.
--단, 사원이 없는 부서의 부서번호도 출력하라.
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.job AS "Job",
        d.deptno AS "DEPT No.",
        d.dname AS "DEPT Name",
        d.loc AS "Location"
FROM emp e
    RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno;

--SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하라.
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.sal AS "Salary",
        d.dname AS "Department",
        d.loc AS "Work Location"
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.job = UPPER('SALESMAN');

--사원번호,이름,업무,급여,급여의 등급,하한 값,상한 값을 출력하라.
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.job AS "Job",
        e.sal AS "Salary",
        RANK() OVER(ORDER BY sal)
FROM emp e;

--EMP 테이블에서 SELF JOIN으로 상사를 출력하라. 
--사원번호(EMPNO), 사원명(ENAME),상사 번호(MGR_NO),상사명(MGR_NAME) , 
--상사가 없는 사람도 출력하라.
SELECT sub.empno AS "EMP No.",
        sub.ename AS "Name",
        super.empno AS "MGR_NO",
        super.ename AS "MGR_NAME"
FROM emp sub
    RIGHT OUTER JOIN emp super
    ON sub.mgr = super.empno;

--상사가 7698인 사원의 이름, 사원번호, 상사번호, 상사명을 출력하라.
SELECT sub.empno AS "EMP No.",
        sub.ename AS "Name",
        super.empno AS "Superior No.",
        super.ename AS "Superior"
FROM emp sub
    RIGHT OUTER JOIN emp super
    ON sub.mgr = super.empno 
WHERE super.empno = 7698 AND sub.empno IS NOT NULL;

--NEW YORK에서 근무하고 있는 사원에 대해 이름, 업무, 급여, 부서명을 출력
SELECT e.ename AS "Name",
        e.job AS "Job",
        e.sal AS "Salary",
        d.dname AS "Department"
FROM emp e
    RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
WHERE d.loc = UPPER('NEW YORK');

--보너스를 받는 사원에 대해 이름, 업무, 급여, 부서명을 출력    
SELECT e.ename AS "Name",
        e.job AS "Job",
        e.sal AS "Salary",
        d.dname AS "Department"
FROM emp e, dept d
WHERE e.deptno = d.deptno 
    AND e.comm IS NOT NULL;
    
--이름 중 L자를 가진 사원에 대해 이름, 업무, 부서명, 부서 위치를 출력    
SELECT e.ename AS "Name",
        e.job AS "Job",
        d.dname AS "Department",
        d.loc AS "Dept Location"
FROM emp e
    RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
WHERE e.ename like UPPER('%L%');

--사원번호, 이름, 업무, 부서번호, 부서명, 위치, 급여, 급여 등급을 출력하라.
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.job AS "Job",
        e.deptno AS "Dept No.",
        d.dname AS "Department",
        d.loc As "Dept Location",
        e.sal As "Salary",
        s.grade AS "Salary Grade"
FROM emp e, dept d, salgrade s
WHERE e.deptno = d.deptno 
    AND e.sal BETWEEN s.losal AND s.hisal;

--SALES 부서에서 근무하는 사원번호, 이름, 부서번호, 부서명, 근무지역을 출력    
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.deptno AS "DEPT No.",
        d.dname AS "Department",
        d.loc AS "DEPT Location"
FROM emp e, dept d
WHERE e.deptno = d.deptno
        AND d.dname = UPPER('SALES');
        
--업무가 MANAGER이거나 CLERK인 사원의 사원번호, 이름, 급여, 업무, 부서명, 급여등급을 출력하라.        
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        e.sal AS "Salary",
        e.job AS "Job",
        d.dname AS "Department",
        s.grade AS "Sal Grade"
FROM emp e, dept d, salgrade s
WHERE (e.deptno = d.deptno
        AND e.sal BETWEEN s.losal AND s.hisal)
        AND (job IN (UPPER('MANAGER'), UPPER('CLERK')));

--사원번호, 사원이름, 사원급여, 상사번호, 상사 이름, 상사의 업무를 출력하라. 
--상사가 없는 사람도 출력하라.        
SELECT sub.empno AS "EMP No.",
        sub.ename AS "Name",
        sub.sal AS "Salary",
        super.empno AS "Superior EMP No.",
        super.ename AS "Superior Name",
        super.job AS "Superior Job"
FROM emp super
    RIGHT OUTER JOIN emp sub
    ON sub.mgr = super.empno;
        
--EMP 테이블에서 그들의 상사보다 먼저 입사한 사원에 대해
--사원이름, 사원의 입사일, 상사 이름, 상사 입사일을 출력
SELECT sub.ename AS "Name",
        sub.hiredate AS "Hiredate",
        super.ename As "Superior Name",
        super.hiredate AS "Superior Hiredate"
FROM emp super, emp sub
WHERE super.empno = sub.mgr
        AND super.hiredate < sub.hiredate;        

--사원의 급여와 사원의 급여만큼 ‘*’를 출력하라, * 하나는 100을 의미한다.
col star  format A55
SELECT e.ename,
        d.dname,
        e.sal/100,
        RPAD('*', TRUNC(sal/100, 0), '*')
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--사원 테이블명을 E,상사 테이블명을 M으로 할 때 
--사원번호(E.EMPNO), 사원이름, 사원 급여, 사원 급여등급, 상사번호(M.EMPNO),
--상사이름, 상사 급여, 상사 급여 등급을 출력하라.  
--단, 상사(M) 테이블에서 부하직원이 없는 사람도 출력하라.
SELECT E.empno AS "EMP No.",
        E.ename AS "Name",
        E.sal AS "Salary",
        S.grade AS "Sal Grade",
        M.empno AS "MGR EMP No.",
        M.ename AS "MGR Name",
        M.sal AS "MGR Salary",
        S.grade As "MGR Sal Grade"
FROM emp E, emp M, salgrade S
WHERE (E.mgr = M.empno) AND (E.sal BETWEEN S.losal AND S.hisal)
        AND (M.sal BETWEEN S.losal AND S.hisal);

--사원번호, 사원 이름, 사원의 급여,사원급여 등급, 상사번호, 상사 부서번호, 상사의 부서명을 
--출력하라. 단, 상사가 없는 사람도 출력하라.
SELECT sub.empno,
        sub.ename,
        sub.sal,
        s.grade,
        sub.mgr,
        super.empno,
        d.dname
FROM emp super
    RIGHT OUTER JOIN emp sub
        ON super.empno = sub.mgr
    RIGHT OUTER JOIN dept d
        ON super.deptno = d.deptno AND sub.deptno = d.deptno,
    salgrade s
WHERE sub.sal BETWEEN s.losal AND s.hisal;

--사원번호, 사원 이름, 사원의 부서번호,사원의 부서명, 
--상사이름, 상사 부서번호, 상사의 근무지역을 출력하라. 
--단, 사원테이블의 상사가 없는 사람도 출력하고 사원이 존재하지 않는 부서번호와 부서명도 출력하라.
SELECT e.empno,
        e.ename,
        e.deptno,
        d.dname,
        m.ename,
        m.empno,
        d.loc
FROM emp e, emp m, dept d
WHERE (e.mgr = m.empno)
        AND (d.deptno = e.deptno)
        AND (d.deptno = m.deptno);


-----------------------------------
SELECT ename AS "Name",
        sal AS "Salary"
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);


SELECT ename AS "Name",
        sal AS "Salary"
FROM emp
WHERE sal > (SELECT AVG(NVL(sal, 0)) FROM emp);


SELECT deptno AS "DEPT No.",
        ename AS "Name",
        sal AS "Salary"
FROM emp
WHERE deptno = 10
        AND sal > (SELECT AVG(NVL(sal, 0)) FROM emp);


SELECT deptno AS "DEPT No.",
        ename AS "Name",
        job AS "Job"
FROM emp
WHERE deptno 10
    AND(
        deptno = (SELECT deptno FROM emp WHERE ename = '이순신')
        AND job = (SELECT job FROM emp WHERE ename = '이순신')
        );

SELECT deptno AS "DEPT NO.",
        ename AS "Name",
        sal
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp WHERE deptno = 10)
        OR
        sal = (SELECT MIN(sal) FROM emp WHERE deptno = 10);


--각 부서에서 최대급여를 받는 사람 추출
SELECT e1.deptno AS "DEPT No.",
        d.dname AS "DEPT",
        e1.ename AS "Name",
        e1.sal AS "MAX Salary"
FROM emp e1, dept d
WHERE e1.deptno = d.deptno 
        AND sal = (
             SELECT MAX(sal)
             FROM emp e2
             WHERE e2.deptno = e1.deptno);


SELECT d.dname AS "DEPT",
        e1.ename AS "Name",
        e1.sal AS "Salary"
FROM emp e1, dept d
WHERE e1.deptno = d.deptno
        AND sal > (
                    SELECT AVG(NVL(e2.sal, 0))
                    FROM emp e2
                    ) 
ORDER BY "DEPT", "Salary";

--각 부서에서 최대급여를 받는 사람을 추출
SELECT d.deptno AS "DEPT No.",
        d.dname AS "DEPT",
        e1.ename AS "Name",
        e1.sal AS "MAX Salary"
FROM emp e1, dept d
WHERE e1.deptno = d.deptno
        AND e1.sal = 
            (SELECT MAX(e2.sal) 
             FROM emp e2
             WHERE e2.deptno = e1.deptno
             );





--사원명, 직책, 소속된 직책의 최대급여 추출
SELECT ename AS "Name",
        job As "Job",
        sal AS "MAX Salary"
FROM emp e1
WHERE sal = (
                SELECT MAX(e2.sal)
                FROM emp e2
                WHERE e2.job = e1.job
                )
ORDER BY "MAX Salary" DESC;


--급여를 가장 많이 받는 3명 추출
SELECT ename AS "Name",
        sal AS "TOP 3"
FROM (SELECT ename,
                sal
        FROM emp
        ORDER BY sal DESC
        )
WHERE ROWNUM <= 3;

--가장 오래 근무한 사람 5명 추출
SELECT d.dname AS "DEPT",
        ename AS "Name",
        hiredate AS "Hiredate"
FROM (
        SELECT ename, hiredate
        FROM emp
        ORDER BY hiredate DESC
        ), dept d
WHERE ROWNUM <= 5;


--부하직원이 없는 사람을 추출
SELECT e.empno AS "EMP No.",
        e.ename AS "Name",
        d.dname AS "DEPT",
        e.job AS "Job"
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND NOT EXISTS (
                    SELECT e2.mgr
                    FROM emp e2
                    WHERE e2.mgr = e.empno)
ORDER BY "EMP No.";

--부서의 급여 합계가 전체 사원의 급여 합계의 30%를 초과하는 부서명과 급여합계를 추출
SELECT d.dname AS "DEPT",
        SUM(e.sal) AS "Total Salary"
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
HAVING SUM(e.sal) > (SELECT SUM(sal)*0.3 FROM emp);



WITH dept_sum AS (SELECT d.dname AS "DEPT",
                            SUM(e.sal) AS "total"
                    FROM dept d, emp e
                    WHERE e.deptno = d.deptno 
                    GROUP BY d.dname)
SELECT ds."DEPT", ds."total"
FROM dept_sum ds
WHERE ds."total" > (SELECT SUM(sal) * 0.3 FROM emp);






----------------
--이름이 ALLEN인 사원과 같은 업무를 하는 사람의 사원번호, 이름, 업무, 급여
SELECT empno,
        ename,
        job,
        sal
FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = UPPER('ALLEN'));


--EMP 테이블의 사원번호가 7521인 사원과 업무가 같고 
--급여가 사원번호가 7934인 사원보다 많은 사원의 사원번호, 이름, 담당업무, 입사일, 급여
SELECT empno,
        ename,
        job,
        hiredate,
        sal
FROM emp
WHERE job = (SELECT job FROM emp WHERE empno = 7521)
        AND sal > (SELECT sal FROM emp WHERE empno= 7934);
        
        
--EMP 테이블에서 급여의 평균보다 적은 사원의 사원번호, 이름, 업무, 급여, 부서번호
SELECT empno,
        ename,
        job,
        sal,
        deptno
FROM emp
WHERE sal < (SELECT AVG(NVL(sal,0)) FROM emp);

--부서별 최소급여가 20번 부서의 최소급여보다 작은 부서의 부서번호, 최소급여
SELECT deptno,
        "min"
FROM (SELECT e.deptno, 
        MIN(e.sal) AS "min"
        FROM emp e 
        GROUP BY deptno)
WHERE "min" < (SELECT MIN(sal) FROM emp WHERE deptno = 20);

--업무별 급여 평균 중 가장 작은 급여평균의 업무와 급여평균
SELECT job,
        MIN(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) = (SELECT MIN(AVG(NVL(sal,0))) FROM emp GROUP BY job);


--업무별 최대 급여를 받는 사원의 사원번호, 이름, 업무, 입사일, 급여, 부서번호
SELECT empno,
        ename,
        job,
        hiredate,
        job,
        deptno
FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY job);


--30번 부서의 최소급여를 받는 사원보다 많은 급여를 받는
--사원의 사원번호, 이름, 업무, 입사일, 급여, 부서번호, 단 30번 부서는 제외
SELECT empno,
        ename,
        job,
        hiredate,
        sal,
        deptno
FROM emp
WHERE sal > (SELECT MIN(sal) FROM emp WHERE deptno = 30)
        AND deptno != 30;

--급여와 보너스가 30번 부서에 있는 사원의 급여와
--보너스가 같은 사원을 30번 부서의 사원은 제외하고 출력하라
SELECT ename
FROM emp
WHERE (sal, comm) IN (SELECT sal, comm FROM emp WHERE deptno = 30)
        AND deptno != 30;
        
        
--BLAKE와 같은 부서에 있는 모든 사원의 이름과 입사일자를 출력        
SELECT ename,
        hiredate
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename=UPPER('BLAKE'));

--평균급여 이상을 받는 모든 사원에 대해 사원의 번호와 이름을 출력, 급여가 많은 순서로..
SELECT empno,
        ename,
        sal
FROM emp
WHERE sal >= (SELECT AVG(NVL(sal, 0)) FROM emp)
ORDER BY sal DESC;

--이름에 T가 있는 사원이 근무하는 부서에서 근무하는 모든 사원에 대해
--사원번호, 이름, 급여를 출력, 사원번호 순서로 출력
SELECT empno,
        ename,
        sal
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%T%' GROUP BY deptno);

--부서위치가 CHICAGO인 모든 사원에 대해 이름, 업무, 급여 출력
SELECT e.ename,
        e.job,
        e.sal,
        d.loc
FROM emp e, dept d
WHERE d.loc = UPPER('CHICAGO');

--KING에게 보고하는 모든 사원의 이름과 급여를 출력
SELECT e.ename,
        e.sal,
        m.ename
FROM emp e, emp m
WHERE m.empno = e.mgr
        AND m.ename = UPPER('KING');
SELECT ename,
        sal
FROM emp
WHERE mgr IN (SELECT empno FROM emp WHERE ename = UPPER('KING'));

--FORD와 업무와 월급이 같은 사원의 모든 정보 출력        
SELECT *
FROM emp
WHERE (job, sal) IN (SELECT job, sal FROM emp WHERE ename = UPPER('FORD'));

--업무가 JONES와 같거나 월급이 FORD 이상인 사원의 이름, 업무, 부서번호, 급여 출력
SELECT ename,
        job,
        deptno,
        sal
FROM emp
WHERE job = (SELECT job FROM emp WHERE ename = UPPER('JONES'))
        OR
        sal >= (SELECT sal FROM emp WHERE ename = UPPER('FROD'));
        
--SCOTT 또는 WARD와 월급이 같은 사원의 이름, 업무, 급여를 출력        
SELECT ename,
        job,
        sal
FROM emp
WHERE sal = (SELECT sal FROM emp WHERE ename IN ('SCOTT', 'WARD'));

--SALES에서 근무하는 사원과 같은 업무를 하는 사원의 이름, 업무, 급여, 부서번호 출력
SELECT ename,
        job,
        sal,
        deptno
FROM emp
WHERE job IN (SELECT job FROM emp, dept WHERE dname='SALES');

--사원번호, 사원명, 부서명, 소속부서 인원수, 업무, 소속 업무 급여평균,급여를 출력
SELECT e.empno,
        e.ename,
        d.dname,
        (SELECT COUNT(*) FROM emp e1 WHERE e1.deptno = d.deptno) AS "Count",
        job,
        (SELECT AVG(NVL(sal,0)) FROM emp e2 WHERE e2.deptno = d.deptno) AS "AVG Sal",
        sal      
FROM emp e, dept d
WHERE e.deptno = d.deptno;        


--사원번호, 사원명, 부서번호, 업무, 급여, 자신의 소속 업무 평균급여를 출력
SELECT empno,
        ename,
        deptno,
        job,
        sal,
        (SELECT AVG(sal) FROM emp e WHERE e.job = s.job) AS "AVG sal"
FROM emp s;

--최소한 한 명의 부하직원이 있는 관리자의 사원번호, 이름, 입사일자, 급여 출력
SELECT empno,
        ename,
        hiredate,
        sal
FROM emp m
WHERE EXISTS (SELECT 1 FROM emp e WHERE e.mgr=m.empno);

--부하직원이 없는 사원의 사원번호, 이름, 업무, 부서번호 출력
SELECT empno,
        ename,
        job,
        deptno
FROM emp m
WHERE NOT EXISTS (SELECT 1 FROM emp e WHERE e.mgr = m.empno);

--BLAKE의 부하직원의 이름, 업무, 상사번호 출력
SELECT e.ename,
        e.job,
        e.mgr
FROM emp e
WHERE e.mgr = (SELECT m.empno FROM emp m WHERE m.ename = UPPER('BLAKE'));


--BLAKE와 같은 상사를 가진 사원의 이름, 업무, 상사번호 출력
SELECT e.ename,
        e.job,
        e.mgr
FROM emp e
WHERE e.mgr = (SELECT m.mgr FROM emp m WHERE m.ename = UPPER('BLAKE'));


COMMIT;