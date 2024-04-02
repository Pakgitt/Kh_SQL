-- CHUN 01 (BASIC)
-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오
-- 단, 출력 헤더는 "학과 명", "계열"로 표시 한다
select department_name "학과 명", category "계열" from tb_department;

-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다
select department_name||'의 정원은'||capacity||' 명 입니다' as "학과별 정원"
from TB_department;

-- 3. "국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생을 찾아 달라는 요청이 들어왔다
-- 누구인가?(국문학과의 학과코드는 학과 테이블을 조회해 알아내도록하자)
select s.student_name from tb_student s
    join tb_department using(department_no)
        where s.absence_yn = 'Y' and department_no = 001 and substr(s.student_ssn,8,1) = 2;

-- 4. 도서관에서 대출 도서가 장기 연체자들을 찾아 이름을 게시하고자 한다
-- 그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적절한 SQL 구문을 작성해라
select student_name from tb_student 
where student_no in('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

select * from tb_student where student_name like'정경환';

INSERT INTO TB_STUDENT (STUDENT_NO, DEPARTMENT_NO, STUDENT_NAME, STUDENT_SSN, STUDENT_ADDRESS, ENTRANCE_DATE, ABSENCE_YN, COACH_PROFESSOR_NO)
VALUES ('A513090', '045', '정경환', '850502-1126048', '서울시 서초구 반포동 한신4차아파트 209-1006', to_date('01-03-2005', 'dd-mm-yyyy'), 'N', 'P079');

-- 5. 입학정원이 20명 이상, 30명 이하인 학과들의 학과 이르뫄 계열을 출력하시오
select department_name, category from tb_department
where capacity between 20 and 30;

-- 6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
-- 그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL을 작성하시오
select professor_name from tb_professor where department_no is null;

-- 7. 혹시 전산상의 착오로 학과가 지정되 있지 않는 학생이 있는지 확인하고자 한다
select student_name from tb_student where department_no is null;

-- 8. 수강신청을 하려한다. 선수과목 여부를 확인해야 하는데, 
-- 선수과목이 존재하는 과목들은 어떤 과목인지 조회해보시오
select class_no from tb_class where preattending_class_no is not null;

-- 9. 춘 대학에는 어떤계열(CATEGORY)들이 있는지 조회하시오
select distinct category from tb_department order by category;

-- 10. 02학번 전주 거주자들의 모임을 만드려한다. 휴학한 사람들은 제외한 재학중인
-- 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성해라
select student_no, student_name, student_ssn from tb_student
where substr(entrance_date, 1, 2) = 02 and student_address like'%전주%'
and absence_yn='N';

-- CHUN 02

-- 1. 영어영문학과(학과코드002) 학생들의 학번과 이름, 입학년도를 입학년도가 빠른
-- 순으로 표시하는 SQL 문장을 작성해라(단, 헤더는 학번,이름,입학년도가 표시되도록 한다)

SELECT student_no 학번, student_name 이름, to_char(entrance_date,'yyyy-mm-dd') 입학년도 from tb_student
where department_no = 002 order by 3;

-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL을 작성해 보자 
select professor_name, professor_ssn from tb_professor 
where not length(professor_name) = 3; 

-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하시오
-- 단, 나이가 적은 사람에서 많은 사람 순으로(2000년 이후 출생자는 없다. 나이는 만 나이)
select professor_name 교수이름, 
trunc(months_between(sysdate,(concat(19,to_date(substr(professor_ssn,1,6), 'rrmmdd'))))/12) as 만나이 from tb_professor 
where substr(professor_ssn, 8,1) = 1 
order by 2;

-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL문장을 작성
select substr(professor_name, 2,2) 이름 from tb_professor ;

-- 5. 재수생 입학자를 구하려고 한다. 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주
select student_no, student_name from tb_student
where extract(year from entrance_date) - extract(year from to_date(substr(student_ssn,1,6))) > 19
order by student_no desc;

select extract(year from entrance_date) from tb_student;
select extract(year from to_date(substr(student_ssn,1,6))) from tb_student;
-- 6. 2020년 크리스마스는 무슨 요일인가
select to_char(to_date('20201225', 'yyyymmdd'),'dy')||'요일' from dual;

-- 7. TO_DATE('99/10/11',YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')는
-- 각각 몇년 몇월 며칠을 의미할까 또 TO_DATE('99/10/11 'RR/MM/DD'),
-- TO_DATE('49/10/11', 'RR/MM/DD')는 각각 몇년 몇월 며칠일까
select 
to_char(to_date('99/10/11', 'yy/mm/dd'),'yyyy"년" MON,DY') 하나, 
to_char(to_date('49/10/11', 'yy/mm/dd'),'yyyy"년" MON,DY') 둘,
to_char(to_date('49/10/11', 'rr/mm/dd'),'yyyy"년" MON,DY') 셋,
to_char(to_date('49/10/11', 'rr/mm/dd'),'yyyy"년" MON,DY') 넷 from dual;

-- 8. 2000년도 이후 입학자들은 학번이 A로 시작한다
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 구해라
select student_no, student_name from tb_student
where student_no not like ('A%');

-- 9. 학번이 A517178인 한아름 학생의 학점 총 평점을 구해라
-- 단, 이때 출력 화면의 헤더는 '평점'이라고 찍히게하고, 점수는 반올림해 소수점 이하 한자리 까지
select round(ap,1) 
from (select avg(point) as ap from tb_student join tb_grade using (student_no)
where student_no = 'A517178');

-- 10. 학과별 학생수를 구하여 학과번호, 학생수의 형태로 만들어 결과 값 출력
select department_no 학과번호, count(*) 학생수 from tb_student
group by department_no order by 1 ;

-- 11. 지도 교수를 배정받지 못한 학생의 수는 몇명일까
select count(*) from tb_student where coach_professor_no is null;

-- 12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구해라
-- 단, 이때 출력 화면의 헤더는 년도, 년도 별 평점 이라고 찍히게하고 점수는 반올림 소수점 이하 한자리
select substr(term_no, 1,4) 년도, avg(point) from tb_grade
where student_no = 'A112113' 
GROUP by substr(term_no, 1,4) ;

-- 13. 학과 별 휴학생 수를 파악하고자 한다 학과 번호와 휴학생 수를 표시해라
select department_no 학과코드명, count(case when absence_yn in ('Y') then 1 else null end)
from tb_student 
group by department_no order by 1;

-- 14. 동명이인 학생들의 이름을 찾고자한다 
select student_name 동명이인, count(*)
from tb_student 
group by student_name
having count(student_name)> 1;

select * from tb_student where student_name like'김보람';

-- 15. 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점,
-- 총 평점을 구하시오 단, 평점은 소수점 1자리까지만 반올림)
SELECT (SUBSTR(TERM_NO,1,4))년도, (SUBSTR(TERM_NO,5,2))학기, ROUND(AVG(POINT)) 평점
FROM tb_grade
    WHERE student_no = 'A112113'
        GROUP BY ROLLUP((SUBSTR(TERM_NO,1,4)), (SUBSTR(TERM_NO,5,2)))
        ORDER BY 1;

-- CHUN 03 
-- 1. 학생이름과 주소지를 표시하시오 
select student_name "학생 이름", student_address 주소지 from tb_student
order by 1;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은순으로 출력
select student_name, student_ssn from tb_student
where absence_yn in 'Y' order by substr(student_ssn,1,6) desc;

-- 3. 주소지가 강원도나 경기도인 학생들중 1900년대 학번을 가진 학생들의 
-- 이름과 학번, 주소를 이름의 오름차순으로 출력
select student_name 학생이룸, student_ssn 학번, student_address 주소
from tb_student where student_no not like 'A%' 
and (student_address like '%강원%' or student_address like '%경기도%')
order by 1 desc;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 출력해라
select professor_name, professor_ssn from tb_professor 
join tb_department using(department_no)
where department_no = 005
order by substr(professor_ssn,1,6);

-- 5. 2004년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려한다
-- 학점이 높은 학생부터 표시하고 학점이 같으면 학번이 낮은 학생부터 표시 
select student_no, to_char(point,'FM9990.00') point from 
(select * from tb_grade where class_no = 'C3118100')
where term_no like 200402
order by point desc, 1;

-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬
select student_no, student_name, department_no from tb_student
order by 2;

-- 7. 과목 이름과 과목의 학과 이름을 출력
select class_name, department_name from tb_class
join tb_department using(department_no)
order by 1;

-- 8. 과목별 교수 이름을 찾으려 한다 과목 이름과 수 이름을 출력해라
select class_name, professor_name from tb_class
join tb_class_professor using(class_no)
join tb_professor using(professor_no);

select * from tb_class
join tb_class_professor using(class_no)
join tb_professor using(professor_no);

-- 9. 8번의 인문사회 계열에 속한 과목의 교수 이름을 찾으려한다
select class_name, professor_name from tb_class c
join tb_class_professor cp using(class_no)
join tb_professor p using(professor_no)
where c.department_no in (select department_no from tb_department
where category like '인문사회');

-- 10. 음악학과 학생들의 평점을 구하려고 한다 음악학과 학생들의
-- 학번, 학생이름, 전체 평점을 출력해라
select student_no 학번, student_name "학생 이름", round(avg(point),1) "전체 평점" from tb_grade g
join tb_student  using(student_no)
where department_no in (select department_no from tb_department where department_name like '음악학과')
group by student_no, student_name order by 1;

-- 11. 학번이 A313047인 학생이 학교에 나오지 않고 있다 지도 교수에게 내용을 전달하기 위한 
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 SQL문을 작성하시오
select d.department_name 학과이름, s.student_name 학생이름, professor_name 지도교수이름 from tb_student s
join tb_department d using(department_no)
join tb_professor on professor_no = s.coach_professor_no
where student_no like 'A313047';

-- 12. 2007년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시해라
select student_name, term_no from tb_grade
join tb_student using(student_no)
join tb_class using(class_no)
where term_no like '2007%' and class_name like '인간관계론';

-- 13. 예체능 계열 과목 중 과목 담당 교수를 한 명도 배정받지 못한 과목을 찾아 그 과목
-- 이름과 학과 이름을 출력해라
select class_name, department_name
from tb_class
join tb_department using (department_no)
left join tb_class_professor using (class_no)
where category in ('예체능')
    and professor_no is null;
    
-- 14. 서반아어학과 학생들의 지도교수를 게시하고자한다 
-- 학생이름과 지도 교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
-- '지도교수 미지정'으로 표시
select s.student_name as 학생이름, 
decode((p.professor_name),null, '지도교수 미지정',p.professor_name) as 지도교수 from tb_student s
left join tb_professor p on s.coach_professor_no = p.professor_no
join tb_department d on d.department_no = s.department_no
where d.department_name in ('서반아어학과');

-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 
-- 학번, 이름, 학과 이름, 평점을 조회
select student_no, student_name, department_name, 평점
from (select student_no, student_name, department_name, avg(point) "평점"
    from tb_student
    join tb_grade using (student_no)
    join tb_department using (department_no)
    where absence_yn in ('N')
        group by student_no, student_name, department_name)
        where 평점 >= 4
    order by student_no;
    
-- 16. 환경조경학과 정공과목들의 과목 별 평점을 파악해라
select class_no, class_name, avg(point) 
from tb_class
join tb_grade using(class_no)
join tb_department using(department_no)
where department_name in (select department_name from tb_department 
where department_name in ('환경조경학과') and class_type in ('전공선택'))
group by class_no, class_name;

-- 17. 최경희 학생과 같은 과 학생들의 이름과 주소를 출력해라
select studednt_name, student_adress from tb_student
join tb_department using(department_no)
where department_name in
(select department_name from tb_department where 


