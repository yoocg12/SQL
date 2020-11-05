--tmp02 table 생성
create table tmp02
(
    a varchar2(100), --세미콜론(;)을 입력할 경우 ORA-00907 오류
    b varchar2(100)
)

--tmp02 table 에 varchar2 Type의 c column 추가. 최대 100Byte까지 입력이 가능.
--한글은 한 글자에 2Byte, 영어나 숫자는 1Byte

Alter table tmp02 add c varchar2(100);


--c column 정상 추가 확인
select *
  from tmp02
