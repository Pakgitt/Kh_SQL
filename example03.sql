-- 실습 03
-- 01. 아래와 같이 조회
select * from emp;

-- 02. 아래와 같이 조회 (sal순)
select * from emp order by sal desc;

-- 03. Deptno가 20, 30인 부서 사람들의 등급별 평균 연봉
-- 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 계산하도록 한다.
-- 2. 연봉 계산은 SAL*12+COMM
-- 3. 순서는 평균연봉이 내림차순으로 정렬한다
select s.grade, avg(sal*12+nvl(comm,0)) 평균연봉 from emp e
join salgrade s on (sal between s.losal and s.hisal) where deptno in (20,30) group by s.grade order by 1 desc ;

select * from salgrade;
select * from emp;
-- 04.
-- 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 조회
-- 2. 연봉 계산은 SAL*12+COMM
-- 3. 순서는 평균연봉이 내림차순으로 정렬한다
select deptno, trunc(avg(sal*12+nvl(comm,0))) 평균연봉 from emp 
where deptno in(20,30) group by deptno order by 2 desc;

-- 05. 사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
select e1.empno, e1.ename, e1.job, e1.mgr, e2.ename MANAGER from emp e1 
left JOIN emp e2 on e1.mgr = e2.empno order by 1;

-- 06. 사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
-- 단, select절에 subquey를 이용
select e1.empno, e1.ename, e1.job, e1.mgr, 
(select e2.ename from emp e2 where e1.mgr = e2.empno) MANAGER
from emp e1;

-- 07. MARTIN의 월급보다 많으면서 ALLEN과 같은 부서이거나 20번인 사원 조회
select * from emp e1 where
e1.sal > (select e2.sal from emp e2 where e2.ename = 'MARTIN') 
and (e1.deptno = (select e3.deptno from emp e3 where e3.ename = 'ALLEN')
or e1.deptno in 20);

select * from emp where ename = 'MARTIN';
select * from emp where ename = 'ALLEN';

-- 08. 'RESEARCH' 부서의 사원 이름과 매니저 이름을 나타내시오
select e1.ename, e2.ename MANAGER from emp e1 
join dept d on d.deptno = e1.deptno 
join emp e2 on e1.mgr = e2.empno
where d.dname = 'RESEARCH';

-- 09. GRADE별로 급여율 가장 작은 사원명 조회
select grade, ename from emp
join salgrade on sal between losal and hisal
where sal in(select min(sal) from emp 
join salgrade on sal between losal and hisal group by grade);

-- 10. GRADE별로 가장 많은 급여, 가장 작은 급여, 평균 급여를 조회
select grade, min(sal), max(sal), round(avg(sal),2) from emp
join salgrade on sal between losal and hisal group by grade;

-- 11. GRADE별로 평균급여에 10프로 내외의 급여를 받는 사원명을 조회 - 정렬
select grade, ename from emp 
    join salgrade on sal < (select e2.ename from emp e2 where sal;

select grade, ename, amt2, amt1, sal 
from emp
join (select 
(losal+hisal)/2 * 1.1 as amt1,
(losal+hisal)/2 * 0.9 as amt2,
grade
from salgrade )
on sal between amt2 and amt1 ;

SELECT GRADE, ENAME 평균10프로내외인사원
    FROM EMP E1
        JOIN SALGRADE S1 ON E1.SAL BETWEEN S1.LOSAL AND S1.HISAL
    WHERE E1.SAL BETWEEN (SELECT AVG(E2.SAL) FROM EMP E2 JOIN SALGRADE S2 ON E2.SAL BETWEEN S2.LOSAL AND S2.HISAL WHERE S1.GRADE = S2.GRADE GROUP BY S2.GRADE) * 0.9 AND
        (SELECT AVG(E2.SAL) FROM EMP E2 JOIN SALGRADE S2 ON E2.SAL BETWEEN S2.LOSAL AND S2.HISAL WHERE S1.GRADE = S2.GRADE GROUP BY S2.GRADE) * 1.1
;

-- 12. 지역 재난 지원금을 사원들에게 추가 지급
-- 1.  NEW YORK지역은 SAL의 2%, DALLAS지역은 SAL의 5%, CHICAGO지역은 SAL의 3%,
-- BOSTON지역은 SAL의 7%
-- 2.추가지원금이 많은 사람 순으로 정렬
SELECT empno, ename, sal,
    decode(loc, 'NEW YORK', sal * 1.02, decode(loc, 'DALLAS', sal * 1.05, decode(loc, 'CHICAGO', sal * 1.03, decode(loc, 'BOSTON', sal * 1.07))))
    AS sal_subsidy
FROM emp
    JOIN dept USING ( deptno )
ORDER BY
    4 DESC;
    
SELECT * FROM EMP;    

