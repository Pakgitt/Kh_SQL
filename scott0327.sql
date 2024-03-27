-- 0327
-- join
select * from emp;
select * from dept;
-- smith 로그인 - 마이페이지를 들어감
select empno, ename, job, mgr, hiredate, sal, emp.deptno, dept.deptno dname, loc
--from emp cross join dept -- cross -- join 조건 필요없음. 카테시안곱(경우의 수 모두) 
from emp join dept on emp.deptno = dept.deptno
--from emp join dept using (deptno) -- using 사용시 select문에서 컬럼 이름이 동일 해야함
--where ename='SMITH' 
--and 
;

select * from emp join dept using (deptno);
select * from emp join dept on emp.deptno = dept.deptno;
select emp.*, dept.*, ename "re_ename", sal "re_sal", loc "re_loc" from emp
join dept on emp.deptno = dept.deptno;

select * from emp join salgrade on emp.sal >= salgrade.losal and emp.sal <= salgrade.hisal;
select ename from emp where ename='SMITH';
select * from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal;
select * from emp e join salgrade s on e.sal between s.losal and s.hisal; -- 테이블에 별칭 주기
delete from salgrade where GRADE = '13';
select * from salgrade;

select * from emp left outer join dept using (deptno);
select * from emp full join dept using (deptno);
select * from emp join dept using (deptno);
select * from emp join dept on emp.deptno = dept.deptno;

-- left dept 데이터를 다 나타냄
select * from dept left outer join emp using (deptno);
select * from dept join emp using (deptno);
select * from dept join emp on emp.deptno = dept.deptno;

select * from emp;
select e.*, d.dname, d.loc, s.grade from emp e 
join dept d on e.deptno = d.deptno 
join salgrade s on e.sal between s.losal and s.hisal;
-- SELF JOIN -- 별칭 필수!
select * from emp e1 join emp e2 on e1.mgr = e2.empno;

-- SUBQUERY -- 항목 개수와 자료형이 동일 해야함
select avg(sal) from emp;
select deptno, max(sal) from emp group by deptno;

select * from emp 
--where (deptno, sal) in (select deptno, max(sal) from emp group by deptno);
--where (deptno, sal) in ( (20,3000), (30,2850),( 10,5000));
where (deptno, sal) in (select deptno, max(sal) from emp where ename<>'KING' group by deptno);

select e.*, (select dname from dept where deptno=e.deptno) dname
    from emp e
    ;
    
