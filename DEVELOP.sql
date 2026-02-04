select *
from board;

update board
set    writer = 'user03'
where board_no = 3;

insert into board (board_no, title, writer, content) 
values (4, 'test', 'user02', '연습글입니다2');

select *
from board;

--추가작업
select *
from dept;