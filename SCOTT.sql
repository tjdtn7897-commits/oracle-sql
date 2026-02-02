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
