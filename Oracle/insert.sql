--전체 컬럼에 값을 입력할 때
insert into student 
values(1,'choi','1990-11-15','master',sysdate);


--일부 컬럼에 값을 입력할 때
insert into student
    (student_id,name,birthday)
values
    (2,'kim','1989-11-30');
