--
select name
      ,to_char(birthday, 'Q') || '/4분기' quarter
      ,ceil(to_char(birthday, 'MM') / 3) || '/4분기' quarter2
      ,decode(to_char(birthday, 'MM')
                     ,'01', '1/4분기','02', '1/4분기','03', '1/4분기'
                     ,'04', '2/4분기','05', '2/4분기','06', '2/4분기'
                     ,'07', '3/4분기','08', '3/4분기','09', '3/4분기'
                     ,'10', '4/4분기','11', '4/4분기','12', '4/4분기') quarter3
from student;

select *
from emp;

select *
from dept;

select e.*, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

--ANSI vs. ORACLE
-- 반드시 알아야함 ★
select *
from emp e
join dept d ON e.deptno = d.deptno
where job = 'SALESMAN';

-- student(profno), professor(profno)
-- 학생번호, 이름, 담당교수번호, 이름
select studno
      ,s.name
      ,p.name
      ,p.profno
from student s
full outer join professor p ON s.profno = p.profno;
-- student, professor 

select *
from student;

select *
from professor;

-- 학생번호, 학생이름, 담당교수이름 / 담당교수없음
-- 0615, Daniel Day-Lewis, Jobue Foster
-- 9712, Sean Connery, 담당교수없음
select s.studno "학생번호"
      ,s.name "학생이름"
      ,NVL(p.name, '담당교수없음') "교수이름"
from student s
left outer join professor p ON s.profno = p.profno;

-- nvl(), decode(), case when end
-- student 지역번호 구분 02(서울) 031(경기도) 051(부산) 그 외(기타)
select name
      ,substr(tel,1, instr(tel, ')', 1)-1) tel 
      ,case substr(tel,1, instr(tel, ')', 1)-1) when '02' then '서울'
                                                when '031' then '경기도'
                                                when '051' then '부산'
                                                else '기타'
      end "지역명"
from student
order by 2;

select name
      ,jumin
      ,case when substr(jumin, 3, 2) between '01' and '03' then '1/4분기'
            when substr(jumin, 3, 2) between '04' and '06' then '2/4분기'
            when substr(jumin, 3, 2) between '07' and '09' then '3/4분기'
            when substr(jumin, 3, 2) between '10' and '12' then '4/4분기'
        end "분기"
from student ;

--123p
select empno
      ,ename
      ,sal
      ,case when sal between '1' and '1000' then 'LEVEL 1'
            when sal between '2' and '2000' then 'LEVEL 2'
            when sal between '3' and '3000' then 'LEVEL 3'
            when sal between '4' and '4000' then 'LEVEL 4'
            when sal between '5' and '5000' then 'LEVEL 5'
      end "LEVEL"
from emp
order by 3;

select job, count(*), sum(sal), round(avg(sal), 1) avg
           ,min(hiredate)
           ,max(hiredate)
from emp
group by job;

-- 부서별 급여합계, 평균급여, 부서별 인원
select d.dname, e.*
from(select sum(sal) "급여합계"
            ,round(avg(sal), 1) "평균급여"
            ,count(*) "인원"
            ,deptno
      from emp 
      group by deptno) e
join dept d ON e.deptno = d.deptno;
--emp dept 조인
select d.dname
      ,sum(e.sal) "급여합계"
      ,round(avg(e.sal + nvl(comm, 0)), 1) "평균급여"
      ,count(*) "인원"
from emp e
join dept d ON e.deptno = d.deptno
group by d.dname;

-- rollup
-- 1) 부서별 직무(job)별 평균급여, 사원수(그룹)
select deptno
      ,job
      ,avg(sal)
      ,count(*)
from emp
group by deptno
        ,job
union
-- 2) 부서별 평균급여, 사원수
select deptno
      ,'소계'
      ,round(avg(sal), 1)
      ,count(*)
from emp
group by deptno
union
-- 3) 평균급여, 사원수
select 99
      ,'전체집계'
      ,round(avg(sal),1)
      ,count(*)
from emp
order by 1;

-- rollup
select deptno
      ,job
      ,round(avg(sal),1)
      ,count(*)
from emp
group by rollup(deptno, job)
order by 1;

-- 게시판(board)
-- 글번호, 제목, 작성자, 글내용, 작성시간, 조회수 --, 수정시간, 수정자...
drop table board;
CREATE table board (
  board_no number(10) primary key,--글번호
  title    varchar2(300) not null,--제목
  writer   varchar2(50) not null,--작성자
  content  varchar2(100) not null,-- 글내용
  created_at date default sysdate--작성시간
);
-- 컬럼추가
alter table board add (cilck_cnt number);
alter table board modify content varchar2(1000);
alter table board modify cilck_cnt number default 0;

desc board;

insert into board (board_no, title, writer, content) 
values (3, 'test', 'user01', '연습글입니다1');

insert into board (board_no, title, writer, content) 
values (2, 'test', 'user02', '연습글입니다2');

select *
from board;
commit;

update board
set    title = 'test3'
where board_no = 3;

