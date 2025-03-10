










-- LENGTH(컬럼명 | 문자열) : 길이반환
SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;


SELECT EMAIL, LENGTH('가나다라마바사')
FROM EMPLOYEE;

---------------------------------------------

-- INSTR(컬럼명 | 문자열, '찾을 문자열' [, 찾기 시작할 위치[, 순번]])
-- 지정한 위치부터 지정한 순번째로 검색되는 문자의 위치를 반환

-- AABAACAABBAA

-- 문자열을 앞에서부터 검색하여 첫번째 B의 위치를 조회
SELECT INSTR('AABAACAABBAA', 'B') -- 3
FROM DUAL;

-- 문자열을 5번째 문자부터 검색하여 첫번째 B의 위치를 조회
SELECT INSTR('AABAACAABBAA', 'B', 5) -- 9
FROM DUAL;

-- 문자열을 5번째 문자부터 검색하여 두번째 B의 위치를 조회
SELECT INSTR('AABAACAABBAA', 'B', 5, 2) -- 10
FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 이메일, 이메일 중 '@' 위치 조회
SELECT EMP_NAME, EMAIL, INSTR(EMAIL,'@')
FROM EMPLOYEE;

---------------------------------------------------

-- SUBSTR('문자열' | 컬럼명, 잘라내기 시작할 위치 [, 잘라낼 길이])
-- 컬럼이나 문자열에서 지정한 위치부터 지정된 길이만큼 문자열을 잘라내서 반환
-- 잘라낼 길이 생략 시 끝까지 잘라냄

-- EMPLOYEE 테이블에서 사원명, 이메일 중 아이디만 조회
-- sun)di@or.kr -> sun_di
SELECT EMP_NAME, SUBSTR(EMAIL, 1,INSTR(EMAIL,'@') - 1) 아이디
FROM EMPLOYEE;

----------------------------------------------------

-- TRIM( [[옵션] '문자열' | 컬럼명 FROM] '문자열' | 컬럼명 )
-- 주어진 컬럼이나 문자열의 앞, 뒤, 양쪽에 있는 지정된 문자를 제거
--> 양쪽 공백 제거에 많이 사용함

-- 옵션 : LEADING(앞쪽), TRAILING(뒤쪽), BOTH(양쪽) <-기본값

SELECT TRIM('     H E L L O     ') -- BOTH기본값
FROM DUAL;

SELECT TRIM(BOTH '#' FROM '####안녕####')
FROM DUAL;

SELECT TRIM(LEADING '#' FROM '####안녕####')
FROM DUAL;

SELECT TRIM(TRAILING '#' FROM '####안녕####')
FROM DUAL;

-----------------------------------------------------

-- 숫자 관련 함수

-- ABS(숫자 | 컬럼명) : 절대값
SELECT ABS(10), ABS(-10) FROM DUAL;

SELECT '절대값' || ' 같음' FROM DUAL
WHERE ABS(10) = ABS(-10); -- WHERE 절 함수 작성 가능

-- MOD(숫자 | 컬럼명, 숫자 | 컬럼명) : 나머지 값 반환

-- EMPLOYEE 테이블에서 사원의 월급을 100만으로 나눴을 때 나머지 조회
SELECT EMP_NAME, SALARY, MOD(SALARY,1000000)
FROM EMPLOYEE e ;

-- EMPLOYEE 테이블에서 사번이 짝수인 사번의 사번, 이름 조회
SELECT EMP_NAME, EMP_ID
FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 0;

-- EMPLOYEE 테이블에서 사번이 홀수인 사번의 사번, 이름 조회
SELECT EMP_NAME, EMP_ID
FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 1;

-- ROUND(숫자 | 컬럼명, [, 소수점 위치]) : 반올림

SELECT ROUND(123.456) FROM DUAL; 
-- 123, 소수점 첫째 자리에서 반올림

SELECT ROUND(123.456,1) FROM DUAL; 
-- 123.5, 소수점 둘째 자리에서 반올림

-- CEIL(숫자 | 컬럼명) : 올림
-- FLOOR(숫자 | 컬럼명) : 내림
SELECT CEIL(123.1),FLOOR(123.9) FROM DUAL;

-- TRUNC(숫자 | 컬럼명 [, 위치]) : 특정 위치 아래를 절삭
SELECT TRUNC(123.456) FROM DUAL; 
-- 123, 소수점 아래를 절삭
SELECT TRUNC(123.456, 1) FROM DUAL; 
-- 123.4, 소수점 첫째자리 아래를 절삭
SELECT TRUNC(123.456, -1) FROM DUAL; 
-- 120, 10의 자리 아래를 절삭

----------------------------------------------

-- 날짜(DATE) 관련 함수

-- SYSDATE : 시스템에 현재 시간(년,월,일,시,분,초)을 반환
SELECT SYSDATE FROM DUAL; 
-- 2025-03-10 12:11:00.000

-- SYSTIMESTAMP : SYSDATE + MS 단위 추가
SELECT SYSTIMESTAMP FROM DUAL; 
-- 2025-03-10 12:12:00.853 +0900

-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜의 개월 수 차이 반환
SELECT ABS(ROUND(MONTHS_BETWEEN(SYSDATE, '2025-07-22'),3)) "수강 기간(개월)"
FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원의 이름, 입사일, 근무한 개월수, 근무 년차 조회
SELECT EMP_NAME, HIRE_DATE, 
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근무한 개월수",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) || '년차' "근무한 년차"
FROM EMPLOYEE;

-- || : 연결 연산자(문자열 이어쓰기)

-- ADD_MONTHS(날짜, 숫자) : 날짜에 숫자만큼의 개월 수를 더함(음수도 가능)
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL; -- 4개월 더함
SELECT ADD_MONTHS(SYSDATE, -1) FROM DUAL; -- 1개월 뺌

-- LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구함
SELECT LAST_DAY(SYSDATE) FROM DUAL; 
SELECT LAST_DAY('2020-02-01') FROM DUAL; 

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴(반환)
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 일만 추출

-- EMPLOYEE 테이블에서
-- 각 사원의 이름, 입사일 조회(입사년도, 월, 일)
-- 2000년 10월 10일
SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE)||'년 '|| 
EXTRACT(MONTH FROM HIRE_DATE)||'월 '|| 
EXTRACT(DAY FROM HIRE_DATE)||'일' AS 입사일
FROM EMPLOYEE;

--------------------------------------------

-- 형변환 함수
-- 문자열(CHAR), 숫자(NUMBER), 날짜(DATE) 끼리 형변환 가능

-- 문자열로 변환
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경

-- 숫자 -> 문자 변환 시 포맷 패턴
-- 9 : 숫자 한칸을 의미, 여러개 작성 시 오른쪽 정렬
-- 0 : 숫자 한칸을 의미, 여러개 작성 시 오른쪽 정렬 + 빈칸 0 추가
-- L : 현재 DB에 설정된 나라의 화폐 기호

SELECT TO_CHAR(1234, '99999') FROM DUAL; -- ' 1234'
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- '01234'
SELECT TO_CHAR(1234) FROM DUAL;					 -- '1234'

SELECT TO_CHAR(1000000,'9,999,999')||'원' FROM DUAL;
SELECT TO_CHAR(1000000,'L9,999,999')||'원' FROM DUAL;

-- 날짜 -> 문자 변환 시 포맷 패턴
-- YYYY : 년도 / YY : 년도(짧게 뒤에만)
-- MM : 월
-- DD : 일
-- AM 또는 PM : 오전/오후 표시
-- HH : 시간 / HH24 : 24시간 표기법
-- MI : 분 / SS : 초
-- DAY : 요일(전체) EX) 월요일 / DY : 요일(요일명만 표시) EX) 월

-- 2025/03/10 12:45:35 월요일
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24/MI/SS DAY')FROM DUAL;

-- 3/10 (월)
SELECT TO_CHAR(SYSDATE, 'MM/DD (DY)') FROM DUAL;

-- 2025년 3월 10일 (월)
SELECT TO_CHAR(SYSDATE,) FROM DUAL;






