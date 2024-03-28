-- 03.28
-- natural join
select * from emp;
select empno, ename, dname from emp natural join dept;

-- SUBQUERY
-- 단일행 -- 2 group by 없이 group함수 사용
select count(distinct sal) from emp;
-- 단일행 -- 2 where Pk 컬럼 명 = 값
select * from emp where empno = 7499;

-- 연산자
-- 'salesman'들의 급여 중 최소값 보다 많은 급여를 받는 사원들이 출력된다.
select empno, ename, sal from emp
where sal > any (select sal from emp where job='SALESMAN');

-- 'manager'사원들 중 최고 급여보다 많은 급여를 받는 사원들이 출력된다.
select empno, ename, sal from emp
where sal > all (select sal from emp where job='MGR');

-- 관리자로 등록되어 있는 사원들 조회
select empno, ename, sal from emp e
where exists (select s.empno from emp s where s.mgr = e.empno);

-- sysdate, rownum
select sysdate, a from (select sysdate a from dual)
where sysdate > to_date('2024-03-28 10:37:39', 'yyyy-mm-dd hh:mi:ss');

-- 우선순위 숙지 ! (INLINE VIEW)
select ename, hiredate from emp order by hiredate;
-- 1 - 5
select * from 
    (select t1.*, rownum r2 from (
    select ename, sal, rownum r1 from emp order by sal desc) t1 
    ) t2
--    where r2 between 1 and 5;
    where r2 between 5 and 10;

select ename, sal, rownum from(
select ename, sal ,rownum r1 from emp order by sal desc) t1 
;

select t1.*, rownum r2 from (
select ename, sal, hiredate,  rownum r1 from emp order by hiredate desc) t1
where rownum between 5 and 11;

-- WITH
with t1 as (select ename, sal, hiredate, rownum r1 from emp order by hiredate desc)
select * from t1;

-- 분석함수 : AVG, SUM, RANK, MAX, MIN, COUNT
-- rank() -- dense_rank(), partition by
with t1 as(
select ename, sal, hiredate, dense_rank() over(order by sal desc) r1 from emp 
)
select * from t1 where r1 between 6 and 10;

select ename, deptno, sal, sum(sal) over() a, sum(sal) over(partition by deptno) b from emp;
select sum(sal) from emp;

-- 순위 함수 : RANK, DENSE_RANK, ROW_NUMBER, NTILE
-- 집계 함수 : SUM, MIX, MAX, 
-- 기타 함수 : LEAD, LAG, FIRST_VALUE, LAST_VALUE, RATIO_TO_REPORT
-- 분석 함수 : KEEP, LISTAGG

select ename, deptno, sal, sum(sal) over(partition by deptno) a,
    rank() over(order by sal desc) b,
    rank() over(partition by deptno order by sal desc) b
from emp;
-- LAG(조회할 범위, 이전 위치, 기준 현재 위치)
select ename, deptno, sal, 
    lag(sal, 1, 0) over(order by sal) 이전값 ,
    -- 1 : 위의 행값, 0 : 이전 행이 없으면 0 처리함
    lag(sal, 1, sal) over(order by sal) "조회2", 
    -- 이전행이 없으면 현재 행의 값을 출력
    lag(sal, 1, sal) over(PARTITION by deptno order by sal)"조회3"
    -- 부서 그룹안에서의 이전 행값 출력
    from emp;
    
SELECT EMPNO, DEPTNO, SAL
    , SUM(SAL) OVER (ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) "win1"
-- rows : 부분그룹인 윈도우의 크기를 물리적인 단위로 행집합을 지정
-- unbounded preceding : 윈도우의 첫행
-- unbounded following : 윈도우의 마지막행
-- current now : 현재 행
-- n PRECEDING : 현재 행을 중심으로 n번째 이전 행
-- n FOLLOWING : 현재 행을 중심으로 n번째 다음 행
--    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "win2"
-- 윈도우의 시작행에서 현재 위치(current row) 까지의 합계를 구해서 win2에
--    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) "win3"
-- 현재 위치에서 윈도우의 마지막행까지의 합계를 구해서 win3에
--    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "win4" -- 1 preceding and 1 following 
-- 현재 행을 중심으로 이전행과 다음행의 급여합계
    FROM EMP
--    WHERE DEPTNO = 30
    ;

-- 현재 조회한(select에 나열된) 컬럼이 아닌 다른 컬럼값으로 정렬하고자 한다면, order by에 서브쿼리를 사용
-- 부서이름으로 정렬하여 emp 테이블의 정보를 조회
select empno, ename, deptno, hiredate, (SELECT LOC FROM DEPT WHERE DEPTNO = E.DEPTNO)
from emp e 
order by (select dname from dept where deptno = e.deptno)desc;

select * from dept order by dname;