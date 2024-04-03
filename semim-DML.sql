---& 대체입력창이 아니라 문자 그대로 동작하도록 함
set define off;

--DROP TABLE "LOGIN_LOG";
--DROP TABLE "BOARD_REPLY";
--DROP TABLE "REPORT";
--DROP TABLE "BOARD_FILE";
--    DROP TABLE "BOARD";
--        DROP TABLE "MEMBER";

-- INSERT 순서는 DROP 반대 순서
-- MEMBER
DESC MEMBER;
--MEM_ID    NOT NULL VARCHAR2(20)  
--MEM_PWD   NOT NULL VARCHAR2(20)  
--MEM_EMAIL NOT NULL VARCHAR2(100) 
--Field3             VARCHAR2(255) 

INSERT INTO MEMBER VALUES('kh1', 'pwd1', 'kh1@bc.com');
INSERT INTO MEMBER VALUES('kh2', 'pwd2', 'kh2@bc.com');
INSERT INTO MEMBER VALUES('kh3', 'pwd3', 'kh3@bc.com');
INSERT INTO MEMBER VALUES('kh4', 'pwd4', 'kh4@bc.com');
INSERT INTO MEMBER VALUES('kh5', 'pwd5', 'kh5@bc.com');

select * from member;

desc board;

--BOARD_ID     NOT NULL NUMBER         
--SUBJECT      NOT NULL VARCHAR2(120)  
--CONTENT      NOT NULL VARCHAR2(4000) 
--WRITE_TIME   NOT NULL TIMESTAMP(6)   
--LOG_IP                VARCHAR2(15)   
--BOARD_WRITER NOT NULL VARCHAR2(20)   
--HIT          NOT NULL NUMBER         


INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval, '제목1', '내용1', DEFAULT, '127.0.0.1','kh1', DEFAULT);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval, '제목2', '내용2', DEFAULT, '127.0.0.1','kh2', DEFAULT);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval, '제목3', '내용3', DEFAULT, '127.0.0.1','kh3', DEFAULT);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval, '제목4', '내용4', DEFAULT, '127.0.0.1','kh4', DEFAULT);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval, '제목5', '내용5', DEFAULT, '127.0.0.1','kh5', DEFAULT);
select * from board order by write_time desc;

desc board_reply;
--BOARD_REPLY_ID         NOT NULL NUMBER         
--BOARD_ID               NOT NULL NUMBER         
--BOARD_REPLY_WRITER     NOT NULL VARCHAR2(20)   
--BOARD_REPLY_CONTENT    NOT NULL VARCHAR2(4000) 
--BOARD_REPLY_WRITE_TIME NOT NULL TIMESTAMP(6)   
--BOARD_REPLY_LOG_IP              VARCHAR2(15)   
--BOARD_REPLY_LEVEL      NOT NULL NUMBER         
--BOARD_REPLY_REF        NOT NULL NUMBER         
--BOARD_REPLY_STEP       NOT NULL NUMBER(3)

---------- TABLE BOARD_REPLY insert
DESC BOARD_REPLY;
--BOARD_REPLY_ID         NOT NULL NUMBER         
--BOARD_ID               NOT NULL NUMBER         
--BOARD_REPLY_WRITER     NOT NULL VARCHAR2(20)   
--BOARD_REPLY_CONTENT    NOT NULL VARCHAR2(4000) 
--BOARD_REPLY_WRITE_TIME NOT NULL TIMESTAMP(6)   
--BOARD_REPLY_LOG_IP              VARCHAR2(15)   
--BOARD_REPLY_LEVEL      NOT NULL NUMBER(2)      
--BOARD_REPLY_REF        NOT NULL NUMBER         
--BOARD_REPLY_STEP       NOT NULL NUMBER(3) 
-- BOARD_ID : 5 댓글들... 달기
-- 
(SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY);
-- 댓글 1 - 원본글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '댓글1' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );
-- 댓글 - 원본글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '댓글2' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );
-- 댓글 - 원본글 
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '댓글3' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );    

-- 1댓글 에 - 대댓글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대댓글1' , default , null, 
    2 , 1, 2  );
-- 1댓글 에 - 대대댓글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대대댓글1' , default , null, 
    3 , 1, 3  );

-- 1댓글 에 - 대댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE BOARD_REPLY_STEP > 1;
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대댓글2' , default , null, 
    2 , 1, 2  );
--- 6 대댓글2에 대대댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE BOARD_REPLY_STEP > 2;
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대대댓글2' , default , null, 
    3 , 1, 3  );

---- 5 에 댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5)
    AND
    BOARD_REPLY_STEP > 
        ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5);
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '5번ㄷㄷ' , default , null, 
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5 )  , 
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5 )  , 
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5 )  );


---- 9 에 댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE BOARD_REPLY_STEP > 
        ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9);
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '9번ㄷㄷ' , default , null, 
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9 )  , 
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9 )  , 
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9 )  );

select * from BOARD_REPLY 
 ORDER BY BOARD_REPLY_REF DESC, BOARD_REPLY_STEP ASC
;
DELETE FROM BOARD_REPLY;

create or replace PROCEDURE pro_board_insert (
    p_writer_key board.board_writer%type, 
    p_subject_Str board.subject%type,
    p_maxcount number)
is 
    v_b board%rowtype;
BEGIN
    for i in 1..p_maxcount loop
    select seq_board_id.nextval into v_b.board_id from dual;
    v_b.board_writer := p_writer_key;
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

select * from member;
select * from board;
desc board;
rollback;

delete from board;
delete from board_reply;
select * from user_sequences;

alter SEQUENCE seq_board_id
maxvalue 999999;
drop SEQUENCE seq_board_id;

desc member;
desc board_reply;
desc board;