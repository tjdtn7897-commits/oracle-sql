select *
from board;

update board
set    writer = 'user03'
where board_no = 3;

insert into board (board_no, title, writer, content) 
values (4, 'test', 'user02', '연습글입니다2');

select *
from board;

-- DML(insert, update, delete, merge)
-- 1) insert into table명 (컬럼1, 컬럼2,....) velues(값1, 값2,...)
select * from board;
-- 4/ 글등록연습/ user01/ sql연습중
update board
set    cilck_cnt = 0;

insert into board (board_no, title, writer, content)
values ((select max(board_no)+1 from board) 
        ,:title 
        ,:writer 
        ,:content);

select * from board;
select max(board_no)+1 from board;

update board
set    cilck_cnt = cilck_cnt + 1
      ,title = :title
      ,content = :content
where board_no = :bno;

select * from board;

delete from board
where content like '%바인드%';

select * from board;

select * from emp;
-- max+1, 이름, SALESMAN, , 2026-02-01, 3000, 10, 30

select * from emp order by 1 desc;
 insert into emp (empno, ename, job, hiredate, sal, comm, deptno)
 values ((select max(empno)+1 from emp)
            ,'김태윤', 'SALESMAN', to_date('2026-02-01', 'rrrr-mm-dd')
            ,3000, 10, 30);

-- 30부서의 MANAGER의 사번.
update emp
set    mgr = (select * from emp
              where deptno = 30
              and job = 'MANAGER')
where empno = 7935;

select empno from emp;

-- 상품테이블(product_tbl)
-- 상품코드, 상품명, 가격, 상품설명, 평점(5,4,3,2,1), 제조사, 등록일자
-- key     natnull  nn   nn          3                   sysdate

CREATE table product_MD (
  product_cd number(10) primary key, --상품코드
  product_name VARCHAR2(100) not null, --상품명
  price    number(5) not null, --가격
  product_dr   varchar2(300) not null, --상품설명
  grade  number(1) default 3, -- 평점
  created_date date default sysdate --등록일자
);

insert into product_MD (product_cd, product_name, price, product_dr, grade)
values ( :product_cd
        ,:product_name --상품명
        ,:price        --가격
        ,:product_dr   --상품설명
        ,:grade );      --평점

select * from product_MD;

select * from product_tbl
order by 1 desc;

-- marge into table1
-- using table2
-- on 병합조건
-- when matched then
-- update ...
-- when not matched then
-- insert ...

merge into product_MD tbl1
using (select :pcode product_code
             ,:pname product_name
             ,:price price
             ,:desc1 descirption
       from dual)tbl2
on (tbl1.product_cd =tbl2.product_code)
when matched then
  update set
      tbl1.product_name = tbl2.product_name
     ,tbl1.price = tbl2.price
     ,tbl1.product_dr = tbl2.descirption
when not matched then
    insert (product_cd, product_name, price, product_dr)
    values (tbl2.product_code, tbl2.product_name, tbl2.price, tbl2.descirption);

select * from product_MD;










