select profno
      ,name
      ,email
from professor
where LENGTH(name) < 10;

-- substr
select 'hello world' 
      ,substr('hello, world', 1, 5) substr1 -- +값이면 왼쪽부터 순번
      ,substr('hello, world', -5, 5) substr2 -- (-값이면 오른쪽 -> 왼쪽순번)
      ,substr('0' || 5, -2, 2) mm
      ,substr('02)3456-2345', 1, instr('02)3456-2345', ')', 1) -1) instr1
      ,substr('031)3456-2345', 1, instr('031)3456-2345', ')', 1) -1) instr2 
      ,instr('031)2345-2312', ')', 1) instr2 -- instr = 문자열에서 찾을 문자열의 위치 반환
from dual;

-- 79p substr / instr 문제
select name
      ,tel
      ,substr(tel, 1,instr(tel, ')', 1)-1) "AREA CODE"
      ,substr(tel
      , instr(tel, ')', 1) + 1
      , instr(tel, '-', -1) - instr(tel, ')', 1)-1) "lst No"
--      ,instr(tel, ')', 1) -- ')' 위치값
--      ,instr(tel, '-', 1) -- '-' 위치값
from student
WHERE deptno1 = 201;

-- lpad / rpad
select rpad('hello', 5, '*')
from dual;

select lpad(ename, 9, '*') 
from emp
where deptno = 10;

select lpad(ename, 9, '123456789') lpad
      ,rpad(ename, 9, substr('123456789', length(ename)+1)) rpad
      ,substr('123456789', length(ename)+1) str
from emp
where deptno = 10;

--ltrim('값', '찾을문자열')
select rtrim ('Hello', 'o')
from dual;

-- replace('값', '찾을문자열', '대체문자열')
select replace('Hello', 'o', 'o, world')
from dual;

select ename
      ,replace(ename, substr(ename, 1, 2), '**') replace
      ,substr(ename, 1, 2) destination
from emp
where deptno = 10;

-- 예제
select replace(ename, substr(ename, 2, 2), '--')
from emp
where deptno = 20;

select name
      ,replace(jumin, 
               substr(jumin, 7, 7), '-/-/-/-')
      ,jumin
from student
where deptno1 = 101;

-- round(123.4)
select round(123.456, -1)
from dual;


--날짜관련함수
select add_months(sysdate, -1) next_month -- 28
      ,months_between(sysdate + 28, sysdate) months
from dual;

select empno   -- 사원번호, 이름, 근속년수 (23년)
      ,ename
      ,hiredate
      ,trunc(months_between(sysdate,hiredate) / 12) || '년' 
      ,mod(trunc(months_between(sysdate, hiredate)), 12) || '개월' "근속년수"
      -- 사원번호, 이름, 근속년수 (23년 7개월)
from emp;

select profno                 --교수번호, 이름, 입사일자, 급여 (30년 이상)
      ,name
      ,hiredate
      ,trunc(months_between(sysdate, hiredate) / 12) || '년'
      ,position
      ,pay
      ,p.deptno
from professor p
where trunc(months_between(sysdate, hiredate) / 12) > 30
order by 3;

-- 학과 테이블 (교수번호, 이름, 입사일자, 급여 (20년이상,  software Engineering)
select profno
      ,name
      ,hiredate
      ,position
      ,d.deptno
      ,pay
from professor p, department d
where p.deptno = d.deptno
AND   d.dname = 'Software Engineering'
AND   trunc(months_between(sysdate, hiredate) / 12) >= 20;

select empno
      ,ename
      ,sal
      ,dname
from emp E, dept D
where E.deptno = D.deptno
AND trunc(months_between(sysdate, hiredate) / 12) >= 40
AND D.dname = 'SALES'
order by E.empno
; -- sales 부서에서 근속년 40년이 넘는 사람. 사번,이름,급여,부서명

select profno, name, p.deptno, d.deptno, dname 
from professor p, department d  --16*12=192
where p.deptno = d.deptno
AND d.deptno = 'Computer Engineering';

-- 2 + '2'
select 2 + to_number('2', 9)
      ,concat(2, '2')
      ,sysdate
from dual
where sysdate > '2026/02/03';

-- to_char(날짜, '포맷문자')
select sysdate
      ,to_char(sysdate, 'RRRR-MONTH-DD HH24:MI:SS') to_char
      ,to_date('05/2024/03', 'MM/RRRR/DD') to_date
from dual;

--to_char
select to_char(12345.6789, '099,999.99') --반올림을 한 연산결과를 문자출력 해줌
from dual;

-- 105p
select studno
      ,name
      ,to_char(birthday, 'DD-MON-RR') birthday
from student
where to_char(birthday, 'MM') = '01';

-- nvl()
select nvl(10,0) -- null ? 0 : 10
from dual;

select pay + nvl(bonus, 0) "월급"
from professor;

-- student테이블(profno) -> 9999 (없으면) / 담당교수번호
--                         담당교수없음/ 담당교수번호
select nvl(profno, 9999) prof1
--      ,nvl(to_char(profno), '담당교수없음') prof2
      ,nvl(profno||'', '담당교수없음') prof2
from student
order by 1 desc
;

<<<<<<< HEAD
-- decode(A, B, '같은조건', '다른조건')
select decode(10, 20, '같다', '다르다') -- 10 == 20 ? '같다' : '다르다'
from dual;

select studno, profno, decode(profno, null, 9999, profno)
from student
order by profno desc;

select decode('C', 'A', '현재A', 'B', '현재B', '기타')
from dual;

-- professor 테이블에서 학과번호와 교수명, 학과명을 출력하되 deptno가 101번인 교수만 학과명
-- 을 "Computer Engineering"으로 출력하고 101번이 아닌 교수들은 학과명에 아무것도 출력하지 마세요.
select profno
      ,name
      ,decode(p.deptno, 101, 101, p.deptno)
      ,decode(dname, 'Computer Engineering', 'Computer Engineering', null, '')
from professor P, department d
;

select *
from professor;





=======
-- 107p 
select empno
      ,ename
      ,sal
      ,comm
      ,to_char ((sal * 12) + comm , '999,999') "SALARY"
from emp
where ename = 'ALLEN';

select name
      ,pay
      ,bonus
      ,to_char ((pay * 12) + bonus, '999,999') "TOTAL"
from professor
where deptno = 201;

-- 108p
select empno, ename, hiredate || ' $' || sal || 
' $' || to_char((sal * 12) + comm, '99,999') "15% up"
from emp
ORDER by 3;

-- 113p
select profno, name, pay, bonus
      ,to_char((pay * 12) + bonus, '999,999') "TOTAL"
from professor
where DEPTNO = 201;

-----------------------------------------------------------
select to_char(birthday, 'MM'),
       decode(to_char(birthday, 'MM'),
       
       1, '1/4분기',
                        2, '1/4분기',
                        3, '1/4분기',
                        4, '2/4분기',
                        5, '2/4분기',
                        6, '3/4분기',
                        7, '3/4분기',
                        8, '3/4분기',
                        9, '3/4분기',
                        10, '4/4분기',
                        11, '4/4분기',
                        12, '4/4분기')
from student
order by 1;
>>>>>>> d22a4e1f86e4a8269ca386913e2f20d9c97025bf



-- 2026.02.03(화) TODO.

-- 107page, 108page, 113page (nvl2)

-- 학생테이블의 생년월일을 기준으로 1~3 => 1/4분기
--                             4~6 => 2/4분기
--                             7~9 => 3/4분기
--                             10~11 => 4/4분기




=======
-- 107p 
select empno
      ,ename
      ,sal
      ,comm
      ,to_char ((sal * 12) + comm , '999,999') "SALARY"
from emp
where ename = 'ALLEN';

select name
      ,pay
      ,bonus
      ,to_char ((pay * 12) + bonus, '999,999') "TOTAL"
from professor
where deptno = 201;

-- 108p
select empno, ename, hiredate || ' $' || sal || 
' $' || to_char((sal * 12) + comm, '99,999') "15% up"
from emp
ORDER by 3;

-- 113p
select profno, name, pay, bonus
      ,to_char((pay * 12) + bonus, '999,999') "TOTAL"
from professor
where DEPTNO = 201;

-----------------------------------------------------------
select to_char(birthday, 'MM'),
       decode(to_char(birthday, 'MM'),
                 1, '1/4분기',
                 2, '1/4분기',
                 3, '1/4분기',
                 4, '2/4분기',
                 5, '2/4분기',
                 6, '3/4분기',
                 7, '3/4분기',
                 8, '3/4분기',
                 9, '3/4분기',
                 10, '4/4분기',
                 11, '4/4분기',
                 12, '4/4분기')
from student
order by 1;

-- 숙제완료.



-- 숙제완료.

