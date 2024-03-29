-- 실습 03
-- 01. 아래와 같이 조회
select * from emp;

-- 02. 아래와 같이 조회 (sal순)
select * from emp order by sal desc;

-- 03. Deptno가 20, 30인 부서 사람들의 등급별 평균 연봉
-- 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 계산하도록 한다.
-- 2. 연봉 계산은 SAL*12+COMM
-- 3. 순서는 평균연봉이 내림차순으로 정렬한다
select deptno, avg(sal*12+comm) from emp where deptno in (20,30) group by grade;
