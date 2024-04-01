-- JOIN

create table author (
    aid number(11) not null,
    name varchar2(10) default null,
    city varchar2(10) default null,
    profile_id number(11) default null,
    primary key(aid)
);
select * from author;

INSERT INTO author VALUES (1, 'egoing', 'seoul', 1);
INSERT INTO author VALUES (2, 'leezche', 'jeju', 2);
INSERT INTO author VALUES (3, 'blackdew', 'namhae', 3);


CREATE TABLE profile (
  pid number NOT NULL,
  title varchar2(10) DEFAULT NULL,
  description clob,
  PRIMARY KEY (pid)
);
SELECT * FROM PROFILE;
INSERT ALL
INTO profile VALUES (1,'developer','developer is ...')
INTO profile VALUES (2,'designer','designer is ..')
INTO profile VALUES (3,'DBA','DBA is ...')
SELECT * FROM DUAL;

CREATE TABLE topic (
  tid NUMBER NOT NULL,
  title varchar2(45) DEFAULT NULL,
  description CLOB,
  author_id varchar2(45) DEFAULT NULL,
  PRIMARY KEY (tid)
);
SELECT * FROM TOPIC;  
INSERT ALL
INTO topic VALUES (1,'HTML','HTML is ...','1')
INTO topic VALUES (2,'CSS','CSS is ...','2')
INTO topic VALUES (3,'JavaScript','JavaScript is ..','1')
INTO topic VALUES (4,'Database','Database is ...',NULL)
SELECT * FROM DUAL;

select * from topic join author on topic.author_id = author.aid;

select * from topic left join author on topic.author_id = author.aid left join profile on author.profile_id = profile.pid;
select * from topic right join author on topic.author_id = author.aid left join profile on author.profile_id = profile.pid;

select tid, topic.title, author_id, name, profile.title as job_title from topic 
left join author on topic.author_id = author.aid left join profile on author.profile_id = profile.pid;

select tid, topic.title, author_id, name, profile.title as job_title from topic 
left join author on topic.author_id = author.aid left join profile on author.profile_id = profile.pid where aid = 1;

select * from topic full outer join author on topic.author_id = author.aid;

select * from employee;
select * from hr.employee a join hr. departments b on b.departsment_id in 1700;
