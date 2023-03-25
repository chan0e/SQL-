-- Active: 1679297594010@@127.0.0.1@3306

-- 1. 영화 '퍼스트 맨'의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요.
select releaseyear, title, runningtime, plot 
from movie 
where title="First Man";

-- 2. 2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
select title, koreantitle 
from movie 
where releaseyear="2003";

-- 3. 영화 '글래디에이터'의 작곡가를 고르세요 //오류
select p.koreanname from person as p
inner join majorrole as mj on p.personid = mj.personid
inner join role as r on mj.roleid = r.roleid
inner join appear as ap on r.roleid = ap.roleid
inner join movie as m on ap.movieid = m.movieid
where m.koreanTitle = "글래디에이터" 
AND
r.rolekorname="작곡";

-- 4. 영화 '매트릭스' 의 감독이 몇명인지 출력하세요 //오류
select count() from person as p 
inner join majorrole as mr on p.personid = mr.personid
inner join role as r on mr.roleid = r.roleid
inner join appear as ap on ap.roleid = r.roleid
inner join movie as mv on mv.movieid = ap.movieid
where r.rolekorname="감독" and mv.koreantitle="매트릭스";

-- 5. 감독이 2명 이상인 영화를 출력하세요

-- 6. '한스 짐머'가 참여한 영화 중 아카데미를 수상한 영화를 출력하세요

-- 7. 감독이 '제임스 카메론'이고 '아놀드 슈워제네거'가 출연한 영화를 출력하세요
select DISTINCT title from movie as m
inner join appear as ap on ap.movieid = m.movieid
inner join role as r on r.roleid = ap.roleid
inner join person as p on ap.personid = p.personid
where koreanname="아놀드 슈워제네거" 
OR 
p.koreanname="제임스 카메론";

-- 8. 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 영화를 고르시오
select * from movie as m 
inner join appear as ap on ap.movieid = m.movieid
inner join person as p  on ap.personid = p.personid
where p.koreanname="레오나르도 디카프리오" 
AND
m.runningtime > 100;

-- 9. 청소년 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화를 고르시오
select title, boxofficewwgross from movie as m
inner join gradeinkorea as gk on gk.gradeinkoreaid = m.gradeinkoreaid
where gradeinkoreaname = "청소년 관람불가"
order by boxofficewwgross desc
LIMIT 1;


-- 10. 1999년 이전에 제작된 영화의 수익 평균을 고르시오
select avg(boxofficewwgross) as '99년이전 영화 수익평균' from movie 
where releaseyear < 1999;


-- 11. 가장 많은 제작비가 투입된 영화를 감독한 사람은 누구입니까?
select p.name , r.rolekorname, m.title from person as p 
inner join appear as ap on ap.personid = p.personid
inner join role as r on ap.roleid = r.roleid
inner join movie as m on ap.movieid = m.movieid
where r.rolekorname="감독"
order by m.budget DESC
LIMIT 1;

-- 12. 제작한 영화의 제작비 총합이 가장 높은 감독은 누구입니까?

-- 13. 출연한 영화의 모든 수익을 합하여, 총 수입이 가장 많은 배우를 출력하세요.

-- 14. 제작비가 가장 적게 투입된 영화의 수익을 고르세요. (제작비가 0인 영화는 제외합니다).
select BoxofficeWWgross, BoxofficeUSgross from movie
where budget <> 0
ORDER BY budget
LIMIT 1 ;

-- 15. 제작비가 5000만 달러 이하인 영화의 미국내 평균 수익을 고르세요
select avg(boxofficeusgross) as '미국내 평균수익' from movie
where budget <= 639540983;

-- 16. 액션 장르 영화의 평균 수익을 집계하세요.
select avg(boxofficewwgross) from movie as m 
inner join moviegenre g on m.movieid = g.movieid 
inner join genre as gr on gr.genreid = g.genreid 
where gr.genrename = "action";


-- 17. 드라마, 전쟁 장르의 영화를 고르세요.
select m.title from movie as m 
inner join moviegenre g on m.movieid = g.movieid 
inner join genre as gr on gr.genreid = g.genreid 
where gr.genrekorname = "드라마"
OR
gr.genrekorname = "전쟁";

-- 18. 톰 행크스가 출연한 영화 중 상영 시간이 가장 긴 영화의 제목, 한글제목, 개봉연도를 출력하세요.
select m.title, m.koreantitle, m.releaseyear from movie as m 
inner join appear as ap on ap.movieid = m.movieid
inner join person as p on ap.personid = p.personid
where p.koreanname='톰 행크스'
ORDER BY m.runningtime DESC;

-- 19. 아카데미 남우주연상을 가장 많이 수상한 배우를 고르시오.

-- 20. 아카데미상을 가장 많이 수상한 영화인을 고르시오 ('수상자 없음'이 이름인 영화인은 제외합니다).

-- 21. 아카데미 남우주연상을 2번 이상 수상한 배우를 고르시오.

-- 23. 아카데미상을 가장 많이 수상한 사람을 고르세요.

-- 24. 아카데미상에 가장 많이 노미네이트 된 영화를 고르세요. //보류
select * from movie as m 
inner join appear as ap on ap.movieid = m.movieid
inner join awardinvolve as ad on ap.appearid = ad.appearid
inner join winning as wn on ad.winningid = wn.winningid;


-- 25. 가장 많은 영화에 출연한 여배우를 고르세요.
select max(mj.count)
from person as p 
inner join majorrole as mj on p.personid = mj.personid
where 여배우;

-- 26. 수익이 가장 높은 영화 TOP 10을 출력하세요.
select BoxofficeWWGross from movie
ORDER BY BoxofficeWWGross desc
limit 10;

-- 27. 수익이 10억불 이상인 영화중 제작비가 1억불 이하인 영화를 고르시오.
select title from movie
where BoxofficeWWGross >= 1000000000
AND
budget <= 100000000 ;

-- 28. 전쟁 영화를 가장 많이 감독한 사람을 고르세요.
 select p.name from person as p 
 inner join majorrole as mj on mj.personid = p.personid
 inner join role as r on r.roleid = mj.roleid
 inner join appear as ap on ap.roleid = r.roleid
 inner join movie as m on m.movieid = ap.movieid
 inner join moviegenre as mg on m.movieid = mg.movieid
 inner join genre as g on mg.genreid = g.genreid
 where g.genrekorname = "전쟁" and r.rolekorname="감독"
 ORDER BY mj.COUNT DESC
 LIMIT 1;  

-- 29. 드라마에 가장 많이 출연한 사람을 고르세요.
 select p.name from person as p 
 inner join majorrole as mj on mj.personid = p.personid
 inner join role as r on r.roleid = mj.roleid
 inner join appear as ap on ap.roleid = r.roleid
 inner join movie as m on m.movieid = ap.movieid
 inner join moviegenre as mg on m.movieid = mg.movieid
 inner join genre as g on mg.genreid = g.genreid
 where g.genrekorname = "드라마" and r.rolekorname = "배우"
 ORDER BY mj.COUNT DESC
 LIMIT 1;  

-- 30. 드라마 장르에 출연했지만 호러 영화에 한번도 출연하지 않은 사람을 고르세요. 
# 확실치 않음
select DISTINCT p.name, g.genrekorname from person as p 
 inner join majorrole as mj on mj.personid = p.personid
 inner join role as r on r.roleid = mj.roleid
 inner join appear as ap on ap.roleid = r.roleid
 inner join movie as m on m.movieid = ap.movieid
 inner join moviegenre as mg on m.movieid = mg.movieid
 inner join genre as g on mg.genreid = g.genreid
 where g.genrekorname = "드라마"  AND g.genrekorname <> "공포"
 and r.rolekorname = "배우";

--  33. 첫 번째 아카데미 영화제가 열린지 올해 기준으로 몇년이 지났나요?
select  2023-ay.year from awardyear as ay
inner join award as aw on ay.awardid = aw.awardid
ORDER BY YEAR 
LIMIT 1;

-- 35. 1999년에서 2009년 사이에 남우 주연상을 수상한 배우를 모두 고르세요.
select p.name from person as p 
inner join appear as ap on ap.personid = p.personid 
inner join awardinvolve as av on av.appearid = ap.appearid
inner join awardyear as ay on ay.awardyearid = av.awardyearid
inner join sector as st on st.sectorid = av.sectorid
where st.sectorkorname = "남우주연상"
 and  
 (ay.year > 1999 and ay.year < 2009);

-- 37. '제임스 카메론'의 영화에 출연한 모든 배우를 고르세요 //오류
select * from person as p
inner join appear as ap on p.personid = ap.personid
inner join role as r on r.roleid = ap.roleid
inner join movie as m on m.movieid = ap.movieid
where r.rolekorname="" ;

select * from movie as m
inner join appear as ap on ap.movieid = m.movieid
inner join role as r on ap.roleid = r.roleid
inner join person as p on ap.personid = p.personid
where p.koreanname="제임스 카메론" or r.rolekorname="배우";

-- 38. '월드 디즈니'가 수상한 아카데미상의 종류를 고르세요


-- 39. 장르별 영화의 제작비 평균을 구하세요.
select avg(m.budget) as 드라마 from movie as m
inner join moviegenre as mg on mg.movieid = m.movieid
inner join genre as g on g.genreid = mg.genreid
where g.genrekorname="드라마";

select avg(m.budget) as 액션 from movie as m
inner join moviegenre as mg on mg.movieid = m.movieid
inner join genre as g on g.genreid = mg.genreid
where g.genrekorname="액션";


-- 40. 장르별 영화의 제작비 대비 수익률을 구하세요.

select sum((m.boxofficeWWgross / m.budget) * 100) as 드라마수익률 from movie as m
inner join moviegenre as mg on mg.movieid = m.movieid
inner join genre as g on g.genreid = mg.genreid
where g.genrekorname="드라마";

select sum((m.boxofficeWWgross / m.budget) * 100) as 드라마수익률 from movie as m
inner join moviegenre as mg on mg.movieid = m.movieid
inner join genre as g on g.genreid = mg.genreid
where g.genrekorname="액션";