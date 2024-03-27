ALTER SESSION set "_ORACLE_SCRIPT"=true;
create user kh identified by kh1234;
--상태: 실패 -테스트 실패: ORA-01045: 사용자 KH는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
grant create SESSION to kh;
REVOKE create SESSION from kh;
create user kh2 identified by kh1234;

grant connect, resource to kh, kh2;

-- 외우기
-- create user 유저명 identified by 비밀번호;
-- grant 권한명, 롤명, ... to 유저명, 유저명2, 롤명
-- revoke 권한명, 롤명, ... from 유저명, 롤명 
-- connect : 접속 관련 권한들로 만들어진 롤명
-- resource : 테이블(객체) 관련 권한들로 만들어진 롤명

