SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;

SELECT * FROM EMPLOYEE 
-- where 속성명 = '속성값'
WHERE DEPT_CODE='D5'; -- 대소문자 구분

SELECT EMP_ID, EMP_NAME, JOB_CODE, HIRE_DATE FROM EMPLOYEE 
-- where 속성명 = '속성값'
WHERE EMP_ID='200';
-- 컬럼 별칭
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS)) * 12 FROM EMPLOYEE;
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS)) "ABCDE" FROM EMPLOYEE;
SELECT EMP_NAME AS 사원이름, SALARY*12 "연봉(원)", (SALARY + (SALARY*BONUS))*12 AS "총 소득(원)" FROM EMPLOYEE;

SELECT EMP_ID, SALARY,'원' AS 단위 FROM EMPLOYEE;
SELECT EMP_ID, SALARY, '원' AS 단위, 1000 AS 구냥 FROM EMPLOYEE;
-- 중복 값 제외하고 한 번씩만 출력
SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;
-- 부서코드가 'D9'인 직원의 이름 부서코드 조회
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE='D9';
-- 급여가 4000000보다 많은 직원 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY > 4000000;
-- 부서코드가'D6'이고 급여를 2000000보다 많이 받는 직원의 이름, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE='D6' AND SALARY > 2000000;
-- 급여가 3000000보다 많고 6000000보다 적은 직원 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE(SALARY >= 3000000) AND (SALARY <= 6000000);
-- between
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY BETWEEN 3000000 AND 6000000;
-- 부서코드가 ‘D6’이거나 급여를 2000000보다 많이 받는 직원의이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE='D6' OR SALARY > 2000000;
-- 부서코드가 'D9'이거나 'D5'인 직원의 이름 부서코드 조회 -- in
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE IN ('D9','D5');
-- not in -- dept_code가 NULL이면 탐색 불가
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE NOT IN ('D9','D5')
OR DEPT_CODE IS NULL; -- null 체크시 is null/is not null 사용
-- salary가 4000000보다 크지 않은 모든 직원
SELECT * FROM EMPLOYEE WHERE NOT (SALARY > 4000000);
-- 연결 연산자
-- 컬럼과 컬럼을 연결한 경우
SELECT EMP_ID || EMP_NAME || SALARY FROM EMPLOYEE;
-- 컬럼과 리터럴을 연결한 경우
SELECT EMP_NAME ||'의 월급은' || SALARY ||'원 입니다' FROM EMPLOYEE;
-- LIKE
-- emp_name이 맨 앞글자가 '전'인 emp_name, salary 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE'전%';
SELECT EMP_NAME, PHONE FROM EMPLOYEE WHERE PHONE LIKE '___7%';
-- ESCAPE
-- EMAIL ID 중'_'의 앞이 3자리인 직원 이름, 이메일 조회
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE'#';
-- NOT LIKE
-- '이'씨 성이 아닌 직원 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMP_NAME NOT LIKE'이%';
SELECT EMP_ID, EMP_NAME, EMAIL FROM EMPLOYEE WHERE NOT EMP_NAME LIKE'이%';
-- DUAL 테이블은 ORACLE에서 임의의 속성 값을 확인하고 싶을 때 사용하는 테이블
SELECT * FROM DUAL;
-- 문자 처리 함수
-- LENGTH 
SELECT EMP_NAME, LENGTH(EMP_NAME), EMAIL, LENGTH(EMAIL) FROM EMPLOYEE;
-- LENGTHB byte
SELECT EMP_NAME, LENGTHB(EMP_NAME), EMAIL, LENGTHB(EMAIL) FROM EMPLOYEE;
-- INSTR
-- EMAIL 컬럼의 문자열중 '@'의 위치를 구하시오
SELECT EMAIL, INSTR(EMAIL,'@', -1,1)위치 FROM EMPLOYEE;
SELECT INSTRB('가나다라마바사','나',2) FROM DUAL;
-- LPAD/RPAD좌/우 N만큼 덧붙여 문자 반환
-- LPAD
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;
-- RPAD
SELECT RPAD('oracle', 20, '#') FROM DUAL;
-- LTRIM/RTRIM 좌/우 문자 제거 후 반환
SELECT EMP_NAME, LTRIM(PHONE,'010'), RTRIM(EMAIL,'@kh.or.kh') FROM EMPLOYEE;
-- TRIM -- 앞/뒤/양쪽 문자 제거 후 반환
SELECT TRIM('           kh         ') FROM EMPLOYEE;
-- SUBSTR -- 지정한 개수 문자열 잘라내어 반환
SELECT * FROM EMPLOYEE;
SELECT SUBSTR('선동일',2,3) FROM EMPLOYEE;
-- LOWER/UPPER/INITCAP -- 소문자/대문자/기본 값
SELECT LOWER('Welcome To My World') FROM EMPLOYEE;
SELECT UPPER('Welcome To My World') FROM EMPLOYEE;
-- CONCAT -- 문자열 합체
SELECT CONCAT('가나다라마','abc') FROM EMPLOYEE;
-- REPLCAE
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

-- 숫자 처리 함수
-- ABS -- 절댓 값 반환
SELECT ABS(10.9) FROM DUAL;
-- MOD -- 나머지 반환
SELECT MOD(10,3) FROM DUAL;
-- ROUND -- 반올림 후 반환
SELECT ROUND(10.51) FROM DUAL;
-- FLOOR -- 소수점 자리 버림 후 반환
SELECT FLOOR(10.51) FROM DUAL;
-- TRUNC -- 특정 자릿수에서 소수점 버림 후 반환
SELECT TRUNC(123.456 ,1) FROM DUAL;
-- CEIL -- 올림 후 반환
SELECT CEIL(10.11) FROM DUAL;

-- 날짜 처리 함수 
-- SYSDATE  
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy-mi-dd hh:mi:ss') FROM DUAL;

SELECT SYSTIMESTAMP FROM DUAL;
-- MONTHS_BETWEEN -- 두 날짜의 개월 수 차이 반환
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) FROM EMPLOYEE;
-- ADD_MONTHS -- 개월 수를 더하여 반환
SELECT EMP_NAME, HIRE_DATE,ADD_MONTHS(HIRE_DATE,6) FROM EMPLOYEE;
-- NEXT_DAY -- 요일이 가장 가까운 날짜 반환
SELECT SYSDATE, NEXT_DAY(SYSDATE,2) FROM EMPLOYEE;
SELECT SYSDATE,NEXT_DAY(SYSDATE,'월요일') FROM EMPLOYEE;
-- LAST_DAY -- 날짜가 속한 달의 마지막 날짜 반환
SELECT EMP_NAME, HIRE_DATE,LAST_DAY(HIRE_DATE) FROM EMPLOYEE;
-- EXTRACT -- 년, 월, 일 정보 추출하여 반환
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)YEAR,
EXTRACT(MONTH FROM HIRE_DATE)MONTH,
EXTRACT(DAY FROM HIRE_DATE)DAY FROM EMPLOYEE;


select emp_name, case when substr(emp_no, 1, 1) = '6' then '60년대생'
                        when substr(emp_no, 1, 1) = '7' then ' 70년대생'
                            else '잘모르겠어염'
                            end "출생년도", emp_no
        from employee;      
select emp_name, decode(substr(emp_no,1,1),'6', '60년대', 'a')s1,
                 decode(substr(emp_no,1,1),'6', '60년대', '7', '70년대')s2
                 from employee;
-- DECODE   
SELECT EMP_ID,emp_name,emp_no, decode(substr(emp_no,8,1),'1','남','여') as 성별 from employee;
-- GROUP 함수

select emp_name, sum(salary) sal from employee;
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
select sum(salary) Sumsal from employee group by job_code;
select sum(salary), job_code from employee group by job_code order by job_code desc;
select dept_code from employee where dept_code='D9';

SELECT * FROM EMPLOYEE ORDER BY DEPT_CODE; -- DEFAULT(ASC) 오름차순
SELECT * FROM EMPLOYEE ORDER BY DEPT_CODE DESC;
SELECT * FROM EMPLOYEE ORDER BY DEPT_CODE NULLS FIRST; -- 널 값 맨 위
SELECT * FROM EMPLOYEE ORDER BY DEPT_CODE, SALARY DESC; -- DEPT_CODE는 오름차순 SALARY는 내림차순

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, (SALARY + (SALARY*nvl(BONUS,0))) * 12 A1 
FROM EMPLOYEE
where dept_code is not null -- and a1 > 300000 -- 오류 수행 순서에 위배
order by a1;

SELECT DEPT_CODE, COUNT(DEPT_CODE) "사원 수", FLOOR(AVG(SALARY)) 평균
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 2000000
ORDER BY 평균 DESC;

-- ROLLUP -- 가장 먼저 지정한 그룹별로 추가적 집계 결과 반환
select dept_code, job_code, count(job_code) 잡코드인원,sum(salary) from employee
group by rollup(dept_code, job_code) order by 1;
-- CUBE -- 지정된 그룹들로 가능한 모든 조합 별로 집계한 결과 반환
select dept_code, job_code, sum(salary) from employee 
where job_code is not null and dept_code is not null group by rollup(dept_code, job_code) order by 1;

select dept_code, job_code, sum(salary) from employee 
where job_code is not null and dept_code is not null group by rollup(job_code, dept_code) order by 1;

select dept_code, job_code, sum(salary) from employee 
where job_code is not null and dept_code is not null group by cube(dept_code, job_code) order by 1;



--SELECT dept_code, job_code, decode(grouping(job_code),1, decode(grouping(dept_code),1,'총합','부합'),
--decode(grouping(dept_code),1,'적합','ㅌ') a1 ,sum(salary))
--    CASE
--        WHEN GROUPING(dept_code) = 0 AND GROUPING(job_code) = 1 THEN '부서별 합계'
--        WHEN GROUPING(dept_code) = 1 AND GROUPING(job_code) = 0 THEN '직급별 합계'
--        WHEN GROUPING(dept_code) = 1 AND GROUPING(job_code) = 1 THEN '총 합계'
--        ELSE '그룹별 합계' END AS 구분
--FROM employee GROUP BY CUBE(dept_code, job_code) ORDER BY 1;