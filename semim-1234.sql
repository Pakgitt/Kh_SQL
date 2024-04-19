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
rollback;

select * from board;
delete board;
select * from member;

commit;

select * from board where board_id=202;

select * from board_reply;


exec pro_board_reply_insert('kh2', '댓글', 202, 0);

INSERT ALL
INTO BOARD (BOARD_ID, SUBJECT, CONTENT, WRITE_TIME, LOG_IP, BOARD_WRITER, HIT)
    VALUES (SEQ_BOARD_ID.NEXTVAL, 'SSS', 'CCC', DEFAULT, NULL, 'KH1', DEFAULT)
INTO BOARD (BOARD_ID, BOARD_FILE_ID, FILE_PATH, ORIGINAL_FILENAME)
    VALUES(SEQ_BOARD_ID.NEXTVAL, 1,'a.jpg','a0.jpg')
INTO BOARD (BOARD_ID, BOARD_FILE_ID, FILE_PATH, ORIGINAL_FILENAME)
    VALUES(SEQ_BOARD_ID.NEXTVAL, 2,'a2.jpg','a0.jpg')
select * from dual;    
    
select * from
    (select * from board where board_id=202)t1
    join (select * from board_reply where board_id=202 order by board_reply_ref desc, board_reply_setp) t2
on t1.board_id = t2.board_id
;