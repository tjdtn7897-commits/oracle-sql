-- Oracle (DBMS) - version(21C) - xe(datavase명)
-- user(scott) - 테이블.
-- Structured Query Language (SQL)
SELECT studno, name -- 칼럼명(전체)
FROM student; -- 테이블명.


-- 1) professor 테이블. 전체 칼럼 조회.
select * from professor;

-- 2) student 테이블에 학생번호, 이름, 학년
select studno, name, grade
from student;

-- 숙제완료함.

select name || '의 아이디는' || id as "전체설명" -- 별칭(alias)
       ,grade "학년"
from student;
-- James Seo의 아이디는 75true이고 4학년입니다 . => alias (학년설명)

select name || '''id is' || '의 ''아이디''는' || id || '이고' || grade || '학년입니다.' 
       as "학년설명" 
from student;

select DISTINCT name, grade -- 중복된값 제거.
from student;

select * from emp;

SELECT name || ' ID: '|| id || ' , ' || 'weight is ' || weight || 'kg' as "ID AND WEIGHT"
from student;

select ename || '(' || job || ')' || ', ' || ename || '''' || job || '''' as "NAME AND JOB"
from emp;

-- WHERE
select * 
from student 
WHERE weight BETWEEN 60 and 70  -- weight >= 60 AND   weight <= 70                     
AND   deptno1 in (101, 201);

select *
from student
WHERE deptno2 is not null;



-- 비교연산자 연습1) emp테이블 급여 3000보다 큰 직원.
select *
from emp
WHERE SAL > 3000;

-- 비교연산자 연습2) emp테이블 보너스 있는 직원들만.
select *
from emp
WHERE comm is not null;

-- 비교연산자 연습3) student테이블 주전공학과:101,102,103인 학생
select *
from student
where deptno1 in(101, 102, 103);

-- 급여가 2000 이상인 직원. 커미션(급여 + 커미션)
SELECt * 
FROM emp
WHERE SAL >= 2000 
OR (SAL+COMM >= 2000);

-- AND / OR
-- IF (sal > 100 || height > 170)

select studno, name, id, grade, height, weight
from student
WHERE (height > 170
OR   weight > 60)
AND  (grade = 4 OR height > 150);

-- 교수 => 연봉이 4000 이상인. 보너스 3번
-- > 교수번호, 이름, 연봉으로 출력
select PROFNO 
        ,name 
        ,pay
        ,bonus
        ,pay * 12 as total_1 
        ,pay * 12 + bonus * 3 as total_2
from professor
where (pay * 12 >= 3000 AND bonus is null)
Or (pay * 12 + bonus * 3 >= 3000 AND bonus is not null)
ORDER BY 5 --정렬기준
;

-- 문자열 like 연산자
select *
from student
WHERE name like '%on____%';

--
select profno
       ,name
       ,pay
       ,bonus
       ,hiredate
from professor
where hiredate > to_date( '1999-01-01', 'rrrr-mm-dd')
order by hiredate; --1970.01.01

--학생테이블, 전화번호(02, 031, 051, 052, 053..)
-- 부산거주.

select name
      ,tel
from student
WHERE TEL like '051%';

-- 이름 M으로 시작 (포함) 8개 이상인 사람만 조회. 

select *
from student
WHERE NAME like 'M_______%';

-- 주민번호 10월달에 태어난 사람 조회.

select *
from student
where jumin like '__10%';

-- 40p 숙제 (이름과 급여) // 이름 's sla is $돈

select ename || '''s' || ' sal ' || 'is ' || '$' || SAL
from emp;

















