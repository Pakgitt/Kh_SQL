
cREATE SEQUENCE seq_file_b_no
start WITH 1
INCREMENT by 1
;

desc member_grade;

insert into member_grade VALUES (1);

select * from member_grade;


desc member;
insert into member values('test1', 1, '諛뺤꽭�쁺', '1234', 'abc@123', '寃쎄린�룄', 1);
select * from member;

desc board_community;
insert into board_community values (1, 'writer1', 'title1', 'content1', sysdate, 1, 1);
select * from board_community;
delete board_community;
INSERT INTO BOARD_COMMUNITY (BOARD_NO, BOARD_WRITER, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITE_TIME, HIT, MEMBER_ADMIN)
VALUES(SEQ_BOARD_ID.NEXTVAL, DEFAULT, ?, ?, DEFAULT, DEFAULT);
ROLLBACK;
DECLARE
    board_no number;
BEGIN
    for i in 1..101 loop
    select seq_board_id.nextval into board_no from dual;
    insert into board_community
    values(
        board_no,
        '작성자'||i,
        '제목-----'||i,
        '내용-----',
        sysdate,
        79,
        1
        );
    end loop;
end;
/

DECLARE
    b_no number;
BEGIN
    for i in 1..101 loop
    select SEQ_FILE_B_NO.nextval into b_no from dual;
    insert into board_file
    values(
        b_no,
        '파일패스'||i,
        '파일본래명'||i,
        i
        );
    end loop;
end;
/


desc board_file;
insert into board_file values (1,'filepath1', 'originalname1', 1);
select * from board_file;
delete board_file;

commit;

select board_no, board_title, file_id, board_writer, board_write_time, hit from board_community left join board_file on b_no = board_no order by 1 desc;

	      select t2.*    from (select t1.*, rownum as rn
		    from (select board_no, board_title, file_id, board_writer, board_write_time, hit
	    from board_community left join board_file on b_no = board_no
			order by 1 desc) t1 ) t2 where rn between 1 and 5;

desc board_file;

