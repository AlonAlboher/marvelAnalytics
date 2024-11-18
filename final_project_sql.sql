-- There are 100 users created between 6 May 2016 and 4 May 2017 , each have their own uniqe ID and username

Select *
From users

-- There are 21 common tags created on July 2024 (no more tags created since)

Select *
from Tags

-- There are 257 photos uploaded by 74 of our users between 1 July 2024 and 7 July 2024

Select *
From Photos

-- There are 1000 likes for photos on our site, All 257 photos got at least 1 like, only 10 users gave likes, the greatest liker has 257 likes, the lowest liker has 55 likes.
-- We get 142 likes per day on avg
-- The avarage likes per user is 100

Select *
from Likes

With cteLikesTotal as
(
select user_id, concat(user_id, photo_id) as IDD 
from likes 
)
,
cteTOTALIDD as
(
Select user_ID, Count (distinct IDD) as COUNTIDD
from cteLikesTotal
Group by user_ID
)
select AVG (COUNTIDD) as AVGLPU
from cteTOTALIDD

Select *, 
ROW_NUMBER ( ) OVER ( partition by created_at order by user_id ) as IDD
From Likes

Select user_id, Count (Distinct created_at) as LikeCount
From Likes
Group by user_id
Order by LikeCount DESC

with CTEAvgLPD as
(
Select Cast(created_at as Date) as CreateDate, Count (Cast(created_at as Date)) as LikeCount
From Likes
Group by Cast(created_at as Date)
)
Select Avg (LikeCount) as AVGLPD
From CTEAvgLPD


-- We have 1000 comments on photos on our page made by 77 of our users, only 35 photos on our page got comments, 
-- The greatest commenters on our site have 35 comments (5 users), the lowest one have  3 comments
-- We get 142 comments per day on avg

Select *
from Comments

Select user_id, Count (Distinct created_at) as CommentCount
From comments
Group by user_id
Order by CommentCount DESC

with CTEAvgCPD as
(
Selec
t Cast(created_at as Date) as CreateDate, Count (Cast(created_at as Date)) as CommentCount
From comments
Group by Cast(created_at as Date)
)
Select Avg (CommentCount) as AVGCPD
From CTEAvgCPD

Select *
From PhotoTags

Select *
From Influencers
Order by _60_day_eng_rate DESC
-- IID 168 - Rkive - Null at _60_day column

Select *
From Follows

