select board_no, board_title, file_id, board_writer, board_write_time, hit from board_community left join board_file on b_no = board_no order by 1 desc;

select board_no, board_title, COUNT(file_id), board_writer, board_write_time, hit from board_community left join board_file on b_no = board_no GROUP by board_no order by 1 desc;

SELECT board_no, board_title, COUNT(file_id), board_writer, board_write_time, hit 
FROM board_community 
LEFT JOIN board_file ON b_no = board_no 
GROUP BY board_no 
ORDER BY board_no DESC;

SELECT board_no, board_title, COUNT(file_id) AS file_count, board_writer, board_write_time, hit
FROM board_community 
LEFT JOIN board_file ON b_no = board_no 
GROUP BY board_no, board_title, board_writer, board_write_time, hit
ORDER BY board_no DESC;



select * from board_file;
delete board_file;
commit;

desc board_reply;
desc board_community;

ALTER table board_reply rename COLUMN b_reply_no to BOARD_NO;
COMMIT;
