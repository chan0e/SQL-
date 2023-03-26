-- -- Active: 1679297594010@@127.0.0.1@3306@datamotionmoviedatabase

-- 1. DBManager 라는 이름을 가지는 사용자를 작성하세요.

create user DBManger IDENTIFIED by '1234';

-- 2. User 라는 이름을 가지는 사용자를 작성하세요.

create user User IDENTIFIED by '0000';

-- 3. DBManger 사용자는 DatamotionMovieDatabase의 모든 개체에 모든 권한을 가지되, 다른 데이터베이스에 대한 권한은 가지지 않아야 합니다.

grant select on datamotionmoviedatabase.* to DBManger;

-- 4. User 사용자는 가지는 데이터베이스의 모든 개체에 대한 읽기 권한과, PersonTrivia 테이블과 MovieTrivia 테이블에는 읽기 및 쓰기 권한을 가집니다.

grant select on datamotionmoviedatabase.* to User;

grant insert on datamotionmoviedatabase.PersonTrivia to User;

grant insert on datamotionmoviedatabase.MovieTrivia to User;

-- 5. '영화'에 출연한 '배우'와 관련된 뷰를 작성하세요.

CREATE VIEW ACTORVIEW AS 
	select p.`Name`
	from person as p
	    inner join appear as ap on ap.personid = p.personid
	    inner join role as r on r.roleid = ap.roleid
	where r.`RoleKorName` =
"배우"; 

-- 6. '영화'를 감독한 '감독'과 관련된 뷰를 작성하세요.

CREATE VIEW DIRECTORVIEW AS 
	select p.`Name`
	from person as p
	    inner join appear as ap on ap.personid = p.personid
	    inner join role as r on r.roleid = ap.roleid
	where r.`RoleKorName` =
"감독"; 

-- 7. '아카데미 시상 결과'과 관련된 뷰를 작성하세요.

CREATE VIEW ACADEMYRESULTVIEW AS 
	select p.name, ay.year, aw.`AwardEnglishTitle`, st.`SectorKorName`
	from person as p
	    inner join appear as ap on ap.personid = ap.personid
	    inner join awardinvolve as av on av.appearid = ap.appearid
	    inner join awardyear as ay on ay.awardyearid = av.awardyearid
	    inner join award as aw on aw.awardid = ay.awardid
	    inner join sector as st on st.sectorid = av.sectorid; 

-- 8. '영화 장르별 제작비와 흥행 수익'에 관련된 뷰를 작성하세요.

-- 9. 영화 '매트릭스' 의 감독이 몇명인지 출력하세요
select count(p.`Name`) from person as p
inner join appear as ap on p.`PersonID` = ap.`PersonID`
inner join role as r on r.`RoleID` = ap.`RoleID`
inner join movie as m on m.`MovieID` = ap.`MovieID`
where m.`KoreanTitle`="매트릭스" AND r.`RoleKorName` = "감독";

-- 10. 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 영화를 출력하세요.
select * from movie as m 
inner join appear as ap on ap.movieid = m.movieid
inner join person as p  on ap.personid = p.personid
where p.koreanname="레오나르도 디카프리오" 
AND
m.runningtime > 100;

-- 11. '알란 실버스트리'가 음악을 작곡한 영화와 '애런 소킨'이 각본을 쓴 영화를 출력하세요. (애런 소킨 데이터를 찾아보세요)

-- 12. '쿠엔틴 타란티노'가 감독한 영화에 출연한 배우들이 출연한 영화의 수익율을 배우별로 출력하세요.

-- 13. 위 문제들 중, 생성한 뷰에서 질의가 어려운 쿼리에 대한 뷰를 작성하세요.

-- 14. 새로 생성한 뷰를 사용해서 쿼리를 다시 작성하세요.

-- 14. 사용자 테이블을 작성하세요. 사용자 테이블은 사용자의 ID, 이름, 패스워드, 전자메일 주소를 필드로 가집니다.
create table user
(
    userid INT,
    username VARCHAR(20),
    useremail VARCHAR(100),
    useraddr VARCHAR(100)

)

-- 15. 사용자가  MovieTrivia 테이블과 PersonTrivia 테이블에 투플을 삽입할 수 있고, 각 투플에 삽입한 사용자를 식별할 수 있는 정보가 포함되어야 할 때, 두 테이블의 릴레이션 스키마를 수정하세요.

-- 16. 수정된 테이블 두 테이블(MovieTrivia, PersonTrivia)과 사용자 테이블 사이의 참조 무결성을 위한 제약조건을 설정하세요.

-- 17. User 사용자가 두 테이블(MovieTrivia, PersonTrivia)에 데이터를 삽입할 수 있도록 권한을 설정하세요.

grant insert on user datamotionmoviedatabase.MovieTrivia to user;
grant insert on user datamotionmoviedatabase.PersonTrivia to user;

-- 18. MovieTrivia 테이블에 데이터를 삽입하는 저장 프로시저를 작성하세요.

-- 19. PersonTrivia 테이블에 데이터를 삽입하는 저장 프로시저를 작성하세요.

-- 20. 주어진 감독이 감독한 영화를 모두 출력하는 저장 프로시저를 작성하세요.

-- 21. 주어진 영화에 출연한 배우를 모두 출력하는 저장 프로시저를 작성하세요.

-- 22. 주어진 영화에 참여한, 감독, 각본, 배우를 제외한 모든 사람을 출력하는 저장 프로시저를 작성하세요.

-- 23. 주어진 사람이 '참여'한 영화를 출력하는 저장 프로시저를 작성하세요.

-- 24. 주어진 장르에 대한 제작비, 전체 수익과 수익율을 출력하는 저장 프로시저를 작성하세요.

-- <수업하지 않은 내용>

-- 25. 저장 프로시저의 파라미터는 출력/입력/입출력 형태의 파라미터를 가질 수 있습니다. 주어진 영화(MovieID)로 출연/참여자 정보를 제외한 모든 정보를 출력 파라미터로 가지고, 실행 결과가 출력 파라미터에 기록되도록 하는 저장 프로시저를 작성하세요.
