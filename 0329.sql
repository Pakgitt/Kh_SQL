-- 0329
drop table employee_copy;
create table employee_copy
    as select emp_id, emp_name, salary, dept_title, job_name
        from employee
        left join department on (dept_code=dept_id)
        left join job using(job_code);
        
CREATE TABLE EMPLOYEE_COPY
    AS SELECT dept_code, EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN JOB USING(JOB_CODE);
        
select * from employee_copy;

select * from employee;

-- VIEW
CREATE or replace VIEW V_EMPLOYEE -- (별칭쓰는곳)
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME, salary
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
        LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
        LEFT JOIN NATIONAL USING(NATIONAL_CODE);

SELECT * FROM V_EMPLOYEE;
--오류 보고 -
--ORA-01031: 권한이 불충분합니다
--01031. 00000 -  "insufficient privileges"
--grant create view..

desc employee;

insert into employee values
('999','홍길똥','123456-1234567','aaa@abc.com','01012345678','D9','J1','1',300000,null,'207',sysdate, null,'N' );
select * from employee order by emp_id desc;
select * from v_employee order by emp_id desc;
--insert into v_employee values ('999','홍길쑨',3000000');

CREATE FORCE VIEW V_TEST
    AS SELECT * FROM FLHASDJKKFLHASDJD;

SELECT * FROM USER_VIEWS;
DROP VIEW V_TEST;

create table employee_copy2 as select * from employee where 1=0;
select * from employee_copy2;
insert into employee_copy2 (select * from employee);
insert into employee_copy2 (select emp_id, emp_name, dept_code as dept_title, job_code as natuonal_name from employee);

CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0;

-- INSERT ALL --
-- EMP_DEPT_D1테이블에 EMPLOYEE테이블의 부서코드가 D1인 직원의 사번, 이름, 소속부서, 입사일을 삽입하고
-- EMP_MANAGER테이블에 EMPLOYEE테이블의 부서코드가 D1인 직원의 사번, 이름, 관리자 사번을 조회하여 삽입
INSERT ALL
    INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT * FROM DUAL;

-- UPDATE
update employee set emp_name='홍길똥똥' where emp_id=999;

-- DDL
select * from dept;
SELECT * FROM EMPLOYEE;
rollback;
-- ALERT
alter table dept add (cdname varchar2(20));
alter table dept add (lname varchar2(20) default '한국');

alter table dept modify lname default'대한민국';