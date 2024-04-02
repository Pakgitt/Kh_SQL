DROP SEQUENCE "SEQ_BOARD_ID";
CREATE SEQUENCE SEQ_BOARD_ID;

DROP TABLE "LOGIN_LOG";
DROP TABLE "BOARD_REPLY";
DROP TABLE "REPORT";
DROP TABLE "BOARD_FILE";
    DROP TABLE "BOARD";
        DROP TABLE "MEMBER";


CREATE TABLE "MEMBER" (
	"MEM_ID"	VARCHAR2(20)		NOT NULL,
	"MEM_PWD"	VARCHAR2(20)		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEM_ID" IS '멤버아이디 영문자,숫자,(-,_) 제공';

COMMENT ON COLUMN "MEMBER"."MEM_PWD" IS '멤버비밀번호 영문자,숫자(!,_,-,~)재공';

COMMENT ON COLUMN "MEMBER"."MEM_EMAIL" IS '멤버이메일 비밀번호재설정시';



CREATE TABLE "LOGIN_LOG" (
	"LOG_TIME"	TMIESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"LOG_IP"	VARCHAR2(15)		NULL,
	"MEM_ID"	VARCHAR2(20)		NOT NULL,
	"LOG_TYPE"	CHAR(1)	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "LOGIN_LOG"."LOG_TIME" IS '로그인아웃시간';

COMMENT ON COLUMN "LOGIN_LOG"."LOG_IP" IS '로그인한 단말의 IPV4(000.000.000.000)';

COMMENT ON COLUMN "LOGIN_LOG"."MEM_ID" IS '멤버아이디 영문자,숫자,(-,_) 제공';

COMMENT ON COLUMN "LOGIN_LOG"."LOG_TYPE" IS '로그인(1), 로그아웃(0)';


CREATE TABLE "BOARD" (
	"BOARD_ID"	NUMBER		NOT NULL,
	"SUBJECT"	VARCHAR2(120)		NOT NULL,
	"CONTENT"	VARCHAR2(4000)		NOT NULL,
	"WRITE_TIME"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"LOG_IP"	VARCHAR2(15)		NULL,
	"BOARD_WRITER"	VARCHAR2(20)		NOT NULL,
	"HIT"	NUMBER	DEFAULT 0	NOT NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_ID" IS '글번호 SEQ_BOARD_ID';

COMMENT ON COLUMN "BOARD"."SUBJECT" IS '글제목';

COMMENT ON COLUMN "BOARD"."CONTENT" IS '글내용';

COMMENT ON COLUMN "BOARD"."WRITE_TIME" IS '글작성시간 (2024-04-02 15:24)';

COMMENT ON COLUMN "BOARD"."LOG_IP" IS '글작성시 단말의IPV4(000.000.000.000)';

COMMENT ON COLUMN "BOARD"."BOARD_WRITER" IS 'ONDELETE SET NULL';

COMMENT ON COLUMN "BOARD"."HIT" IS '글읽기시+1';




CREATE TABLE "REPORT" (
	"MEM_ID"	VARCHAR2(20)		NOT NULL,
	"BOARD_ID"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REPORT"."MEM_ID" IS '멤버아이디 영문자,숫자,(-,_) 제공';

COMMENT ON COLUMN "REPORT"."BOARD_ID" IS '글번호 SEQ_BOARD_ID';


CREATE TABLE "BOARD_FILE" (
	"BOARD_FILE_ID"	NUMBER	DEFAULT 1	NOT NULL,
	"BOARD_ID"	NUMBER		NOT NULL,
	"SAVED_FILE_PATH_NAME"	VARCHAR2(1000)		NOT NULL,
	"ORIGINAL_FILENAME"	VARCHAR2(300)		NOT NULL
);

COMMENT ON COLUMN "BOARD_FILE"."BOARD_FILE_ID" IS 'BOARD_ID마다 임의의숫자 식별자';

COMMENT ON COLUMN "BOARD_FILE"."BOARD_ID" IS '글번호 SEQ_BOARD_ID';

COMMENT ON COLUMN "BOARD_FILE"."SAVED_FILE_PATH_NAME" IS '파일경로명(YYYYMMDDHHMISS_0000.TXT)';

COMMENT ON COLUMN "BOARD_FILE"."ORIGINAL_FILENAME" IS '클라이언트전송한파일명';



CREATE TABLE "BOARD_REPLY" (
	"BOARD_REPLY_ID"	NUMBER		NOT NULL,
	"BOARD_ID"	NUMBER		NOT NULL,
	"BOARD_REPLY_WRITER"	VARCHAR2(20)		NOT NULL,
	"BOARD_REPLY_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"BOARD_REPLY_WRITE_TIME"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"BOARD_REPLY_LOG_IP"	VARCHAR2(15)		NULL,
	"BOARD_REPLY_LEVEL"	NUMBER	DEFAULT 1	NOT NULL,
	"BOARD_REPLY_REF"	NUMBER		NOT NULL,
	"BOARD_REPLY_STEP"	NUMBER(3)	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_ID" IS '댓글-1단계';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_ID" IS '글번호 SEQ_BOARD_ID';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_WRITER" IS '멤버아이디 영문자,숫자,(-,_) 제공';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_CONTENT" IS '댓글내용';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_WRITE_TIME" IS '댓글작성시간';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_LOG_IP" IS '글작성시단말의IPV4(000.000.000.000)';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_LEVEL" IS '댓글1,대댓글2,대대댓글3';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_REF" IS '최초댓글의 번호 BOARD_REPLY_ID';

COMMENT ON COLUMN "BOARD_REPLY"."BOARD_REPLY_STEP" IS '최초댓글기준으로 몇번째위치인지 나타냄';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEM_ID"
);

ALTER TABLE "LOGIN_LOG" ADD CONSTRAINT "PK_LOGIN_LOG" PRIMARY KEY (
	"LOG_TIME",
	"LOG_IP",
	"MEM_ID"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_ID"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "PK_REPORT" PRIMARY KEY (
	"MEM_ID",
	"BOARD_ID"
);

ALTER TABLE "BOARD_FILE" ADD CONSTRAINT "PK_BOARD_FILE" PRIMARY KEY (
	"BOARD_FILE_ID",
	"BOARD_ID"
);

ALTER TABLE "BOARD_REPLY" ADD CONSTRAINT "PK_BOARD_REPLY" PRIMARY KEY (
	"BOARD_REPLY_ID"
);

ALTER TABLE "LOGIN_LOG" ADD CONSTRAINT "FK_MEMBER_TO_LOGIN_LOG_1" FOREIGN KEY (
	"MEM_ID"
)
REFERENCES "MEMBER" (
	"MEM_ID"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"BOARD_WRITER"
)
REFERENCES "MEMBER" (
	"MEM_ID"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_MEMBER_TO_REPORT_1" FOREIGN KEY (
	"MEM_ID"
)
REFERENCES "MEMBER" (
	"MEM_ID"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_BOARD_TO_REPORT_1" FOREIGN KEY (
	"BOARD_ID"
)
REFERENCES "BOARD" (
	"BOARD_ID"
);

ALTER TABLE "BOARD_FILE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_FILE_1" FOREIGN KEY (
	"BOARD_ID"
)
REFERENCES "BOARD" (
	"BOARD_ID"
);

ALTER TABLE "BOARD_REPLY" ADD CONSTRAINT "FK_BOARD_TO_BOARD_REPLY_1" FOREIGN KEY (
	"BOARD_ID"
)
REFERENCES "BOARD" (
	"BOARD_ID"
);

ALTER TABLE "BOARD_REPLY" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_REPLY_1" FOREIGN KEY (
	"BOARD_REPLY_WRITER"
)
REFERENCES "MEMBER" (
	"MEM_ID"
);
