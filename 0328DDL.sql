 -- DDL
-- create table
create table member(
    mb_id varchar2(20),
    mb_pw varchar2(20),
    mb_name varchar2(20)
    );
-- 컬럼 주석
comment on column memeber.mb_id is'회원아이디';
comment on column memeber.mb_pw is'비밀번호';
comment on column memeber.mb_name is'회원이름';

-- 제약 조건
-- NOT NULL
create table USER_NOTNULL(
    user_no number NOT NULL,
    user_id varchar2(20) NOT NULL,
    user_pw varchar2(30) NOT NULL,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
);
select * from user_notnull;
insert into user_notnull 
values(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com');

--insert into user_notnull 
--values(2,null,'pass01','홍길동','남','010-1234-5678','hong123@abc.com');

-- UNIQUE
create table USER_UNIQUE(
    user_no number,
    user_id varchar2(20) UNIQUE,
    user_pw varchar2(30) NOT NULL,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
);
select * from user_unique;
insert into user_unique values(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com');
insert into user_unique values(1,null,'pass01','홍길동','남','010-1234-5678','hong123@abc.com');

CREATE TABLE USER_UNIQUE3(
USER_NO NUMBER,
USER_ID VARCHAR2(20),
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50),
UNIQUE (USER_NO, USER_ID) --두 컬럼을 묶어 한 UNIQUE제약조건 설정
);
drop table user_unique3;
select * from user_unique3;
insert into user_unique3 values(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com');
insert into user_unique3 values(2,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com');
insert into user_unique values(2,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com');

-- primary key -- NOT ULL & UNIQUE

-- FOREIGN KEY 

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
SELECT * FROM USER_GRADE;
INSERT INTO USER_GRADE VALUES (10,'일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');

DELETE FROM USER_GRADE WHERE GRADE_CODE=30; -- 자식이 있어 위배됨

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER REFERENCES USER_GRADE (GRADE_CODE) ON DELETE SET NULL -- 해당 컬럼 삭제시 값을 NULL로 설정
);
DROP TABLE USER_FOREIGNKEY;
SELECT * FROM USER_FOREIGNKEY;

INSERT INTO user_foreignkey VALUES(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com', 10);
INSERT INTO user_foreignkey VALUES(2,'user02','pass01','홍길동','남','010-1234-5678','hong123@abc.com', 20);
INSERT INTO user_foreignkey VALUES(3,'user03','pass01','홍길동','남','010-1234-5678','hong123@abc.com', 30);

-- CHECK
CREATE TABLE USER_CHECK(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) CHECK (GENDER IN ('남', '여')),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50)
);
select * from user_check;
INSERT INTO user_check VALUES(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@abc.com');
INSERT INTO user_check VALUES(2,'user02','pass01','홍길동','여','010-1234-5678','hong123@abc.com');