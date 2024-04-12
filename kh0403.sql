-- 2024.04.03
----------------PL/SQL-----------------
-- console창 처럼 디버깅 창에 결과를 볼 수 있게 해줌
SET SERVEROUTPUT ON;

-- sql developer 프로그램 메뉴 보기 > DBMS 출력 창으로 확인

BEGIN
    dbms_output.put_line('Hello World');
END;
/
DECLARE
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
BEGIN
    EMP_ID := 888;
    EMP_NAME := '배장남';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/


DECLARE
    type empno_table_type is table of emp.empno%type index by BINARY_INTEGER;
    v_arr_no    empno_table_type;
    type ename_table_type is table of emp.ename%type index by BINARY_INTEGER;
    v_arr_name  ename_table_type;
    
    v_idx BINARY_INTEGER := 0;
BEGIN
    dbms_output.put_line(v_idx);
    
    for vo in (select * from emp) loop
    -- 여기를 여러번 반복
    dbms_output.put_line(v_idx);
--    dbms_output.put_line(vo.empno || ':' ||vo.sal);
    v_idx := v_idx+1;
    
    v_arr_no(v_idx) := vo.empno;
    v_arr_name(v_idx) := vo.ename;
     dbms_output.put_line(v_idx ||' : ' || v_arr_no(v_idx) || ':' || v_arr_name(v_idx));
    end loop;
    
--    for i in 0..v_idx-2 loop
    for i in 1..v_idx loop
        dbms_output.put_line(v_arr_no(i));
    end loop;

--    for i in 2..9 loop
--        for j in 1..9 loop
--            dbms_output.put_line(i||'*'||j||'='||i*j);
--        end loop;
--    end loop;
--    
END;
/

--------------
-- 타입 변수 선언
-- 변수의 선언과 초기화, 변수 값 출력
DECLARE
    emp_id number;
    emp_name varchar2(30);
begin
    emp_id := 888;
    emp_name := '배장남';
    dbms_output.put_line('사원ID : ' || emp_id);
    dbms_output.put_line('사원이름 : ' || emp_name);
end;
/
select * from employee;

-- 레퍼런스 변수의 선언과 초기화, 변수 값 출력
declare
    v_emp_id employee.emp_id%type;
    v_emp_name employee.emp_name%type;
BEGIN
    select emp_id, emp_name
    into v_emp_id, v_emp_name
    from employee
    where emp_id = '&emp_id';
    dbms_output.put_line('사원ID : '|| v_emp_id);
    dbms_output.put_line('사원이름 : '|| v_emp_name);
end;
/

-- 한 행에 대한 ROWTYPE변수의 선언과 초기화, 값 출력
declare
    E employee%rowtype;
begin
    select * into e
    from employee
    where emp_id = '&emp_id';
    dbms_output.put_line('EMP_ID : ' || E.EMP_ID);
    dbms_output.put_line('EMP_NAME : ' || E.EMP_NAME);
    dbms_output.put_line('EMP_NO : ' || E.EMP_NO);
    dbms_output.put_line('SALARY : ' || E.SALARY);
end;
/

-- 레코드 타입의 변수 선언과 초기화, 변수 값 출력
declare
    type emp_record_type is record (
        emp_id employee.emp_id%type,
        emp_name employee.emp_name%type,
        dept_title department.dept_title%type,
        job_name job.job_name%type
        );
        
        emp_record emp_record_type;
begin
    select emp_id,emp_name,dept_title,job_name
    into emp_record
    from employee e, department d, job j
    where e.dept_code = d.dept_id
          and e.job_code = j.job_code
          and emp_name = '&emp_name';
          
    dbms_output.put_line('사번 : ' || emp_record.emp_id);
    dbms_output.put_line('이름 : ' || emp_record.emp_name);
    dbms_output.put_line('부서 : ' || emp_record.dept_title);
    dbms_output.put_line('직급 : ' || emp_record.job_name);

end;
/

-- IF ~ THEN ~ END IF
declare
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
begin
    SELECT emp_id, emp_name, salary, bonus
    into emp_id, emp_name, salary, bonus
    from employee
    where emp_id = '&EMP_ID';
    
    dbms_output.put_line('사번 : ' || EMP_ID);
    dbms_output.put_line('이름 : ' || EMP_NAME);
    dbms_output.put_line('급여 : ' || SALARY);
    
    if(bonus = 0 or bonus is null)
        then dbms_output.put_line('보너스없음');
    end if;
    dbms_output.put_line('보너스율 : ' || bonus*100|| '%');
end;
/
select * from employee;

-- IF ~ THEN ~ ELSE ~ END IF
DECLARE
    emp_id employee.emp_id%type;
    emp_name employee.emp_name%type;
    dept_title department.dept_title%type;
    national_code location.national_code%type;
    team varchar(20);
BEGIN
    select emp_id, emp_name, dept_title, national_code
    into emp_id, emp_name, dept_title, national_code
    from employee e, department d, location l
    where e.dept_code = d.dept_id
          and d.location_id = l.local_code
          and emp_id = '&EMP_ID';
    
    if(national_code='KO') then team := '국내팀';
    else team := '해외팀';
    end if;
    
    dbms_output.put_line('사번 : ' || emp_id);
    dbms_output.put_line('이름 : ' || emp_name);
    dbms_output.put_line('부서 : ' || dept_title);
    dbms_output.put_line('소속 : ' || team);
END;
/

-- IF ~ THEN ~ ELSIF ~ ELSE ~ END IF
DECLARE
    score int;
    grade varchar2(2);
BEGIN
    score :='&score';
    
    if score >= 90 then grade := 'A';
    elsif score >= 80 then grade := 'B';
    elsif score >= 70 then grade := 'C';
    elsif score >= 60 then grade := 'D';
    else grade := 'F';
    end if;
    
    dbms_output.put_line('너의 점수는 ' ||score||'점 이고, 학점은 '||grade||'학점 이다');
END;
/

-- 반복문
-- BASIC LOOP
declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n := n+1;
        
        if n>5 then exit;
        end if;
    end loop;
end;
/

-- FOR LOOP
BEGIN
    for n in 1..5 loop
        dbms_output.put_line(n);
    end loop;
END;
/

BEGIN
    for n in reverse 1..5 loop -- 반대로 출력
        dbms_output.put_line(n);
    end loop;
END;
/

-- WHILE LOOP
declare
    n number := 1;
begin
    while n <= 5 loop
        dbms_output.put_line(n);
        n:=n+1;
    end loop;
end;
/


-- 예외처리

declare
    dub_empno EXCEPTION;
    pragma EXCEPTION_init(dub_empno, -00001);
begin
    update employee
    set emp_id = '&사번'
    where emp_id = 202;
EXCEPTION
    when dub_empno
    then dbms_output.put_line('이미존재함');
end;
/

DECLARE
    AAA_UK EXCEPTION;
    PRAGMA EXCEPTION_INIT(AAA_UK, -00001);
    BBB_OVERFLOW EXCEPTION;
    pragma exception_init(BBB_OVERFLOW, -12899);
BEGIN
    UPDATE EMPLOYEE 
--    SET EMP_ID = '&사번'
    SET EMP_ID = '785424'
    WHERE EMP_ID = 201;
EXCEPTION
    WHEN AAA_UK
    THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
    WHEN BBB_OVERFLOW
    THEN DBMS_OUTPUT.PUT_LINE('4자리 숫자입력해주세요. 자릿수보다 큰 값은 허용되지 않습니다.');
END;
/
desc employee;

select * from employee;

CREATE OR REPLACE PROCEDURE PROC_TEST1
IS
    AAA_UK EXCEPTION;
    PRAGMA EXCEPTION_INIT(AAA_UK, -00001);
    BBB_OVERFLOW EXCEPTION;
    pragma exception_init(BBB_OVERFLOW, -01438);
BEGIN
    UPDATE EMPLOYEE 
    SET EMP_ID = 785424
    WHERE EMP_ID = 201;
EXCEPTION
    WHEN AAA_UK
    THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
    WHEN BBB_OVERFLOW
    THEN DBMS_OUTPUT.PUT_LINE('4자리 숫자입력해주세요. 자릿수보다 큰 값은 허용되지 않습니다.');
END;
/

EXEC PROC_TEST1;

--SELECT * FROM user_sequences;
--select * from user_tables;
--select * from user_source;

create or replace procedure pro_select_empno (
        v_empno  in   emp.empno%TYPE, 
        v_ename  out  emp.ename%TYPE, 
        v_sal    out  emp.sal%TYPE, 
        v_comm   out  emp.comm%TYPE
)
is
begin
    select ename, sal, comm
    into v_ename, v_sal, v_comm
    from emp
    where empno = v_empno;
end;
/

variable a_name varchar2(100);
variable a_sal number;
variable a_comm number;

exec pro_select_empno(7788, :a_name, :a_sal, :a_comm);
print a_name;
print a_sal;
print a_comm;

select * from board;

create or replace PROCEDURE pro_board_insert (
    p_writer_key board.board_writer%type, 
    p_subject_Str board.subject%type,
    p_maxcount number)
is 
    v_b board%rowtype;
BEGIN
    for i in 1..p_maxcount loop
    select seq_board_id.nextval into v_b.board_id from dual;
    v_b.board_writer := 'p_writer_key'||I;
    insert into board
    values(
        v_b.board_id,
        p_subject_str||i,
        '내용-----'||I,
        default,
        '127.0.0.1',
        v_b.board_writer,
        default
        );
    end loop;
end;
/
exec pro_board_insert('kh1','제목',5);


-- RPOCEDURE
create table emp_dup
    as select * from employee;
    
select * from emp_dup;

create or replace procedure del_all_emp
is 
begin
    delete from emp_dup;
    commit;
end;
/

desc user_source;

select * from user_source; -- 프로시저 코드보기

-- 매개변수 있는 프로시저 
create or replace view v_emp_job(사번, 이름, 직급, 성별, 근무년수)
as select emp_id, emp_name, job_name,
    decode(substr(emp_no,8,1),1,'남',2,'여'),
    extract(year from sysdate)-EXTRACT(year from hire_date)
    from employee
    join job using(job_code);

select * from v_emp_job;

-- FUNCTION
create or replace function bonus_calc(v_empid employee.emp_id%type)
RETURN number
is
    v_sal employee.salary%type;
    v_bonus employee.bonus%type;
    calc_sal number;
BEGIN
    select salary,nvl(bonus,0)
    into v_sal, v_bonus
    from employee
    where emp_id = v_empid;
    
    calc_sal := (v_sal + (v_sal +v_bonus)) * 12;
    RETURN calc_sal;
end;
/

begin
     :var_emp_id := &emp_id;
     :var_calc := bonus_calc(:var_emp_id);
end;
/

print var_calc;

delete from board_reply;
delete from board;
commit;