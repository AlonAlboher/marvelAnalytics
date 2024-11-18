/* This SQL file is exploring the social media demo data 
	for the final project of the Super team (team3) Int college data analysts class of 2024.

	Below are the tables we were working with:*/

/* USERS table columns - ID, user Name and creation date.
   There are 100 users created between 6 May 2016 and 4 May 2017
   Each user have their own uniqe ID and username */

Select *
From users

Select distinct id
from users

Select distinct username
from users

Select top 1 cast (created_at as date) as CreateDate
from users
Group by cast (created_at as date)
order by CreateDate ASC

Select top 1 cast (created_at as date) as CreateDate
from users
Group by cast (created_at as date)
order by CreateDate DESC

-- TAGS table columns - ID, Tag Name and Creation date
-- There are 21 "common" tags created on July 2024 (no tags created before or since)
-- Each tag has it's own uniqe ID and name

Select *
from tags

Select distinct id
from tags

Select distinct tag_name
from tags

-- PHOTOS TABLE columns - ID, URL, User ID, Creation date
-- There are 257 photos uploaded by 74 of our users between 1 July 2024 and 7 July 2024
-- Each photo have a uniqe ID and URL

Select *
From Photos

Select distinct id
from Photos

Select distinct image_url
from Photos

Select distinct user_id
from Photos

Select top 1 created_at
from Photos
order by created_at ASC

Select top 1 created_at
from Photos
order by created_at DESC

-- LIKES TABLE - User ID, Photo ID, Creation date
-- The uniqe PK of a like is the connection between the user ID and the photo ID (single connection) as every user can only like a spisific picture 1 time
-- There are 1000 likes for photos on our site, All 257 photos got at least 1 like, 
-- Only 10 users gave likes, the greatest liker has 257 likes, the lowest liker has 55 likes.
-- We get 142+ likes per day on avg (rounded), The avarage likes per active user is 100 (users giving likes)

Select *
from Likes

Select distinct concat (user_id, photo_id) as LikePK
from Likes

Select distinct user_id
from Likes

Select user_id, count (user_id) as LikeCount
from Likes
Group by user_id
Order by LikeCount DESC

Select top 1 created_at
from Likes
order by created_at ASC

Select top 1 created_at
from Likes
order by created_at DESC

-- Caculating the avarage likes per user (LPU)
With cteLikesTotal as
(
select user_id, concat(user_id, photo_id) as IDD 
from likes 
),
cteTOTALIDD as
(
Select user_ID, Count (distinct IDD) as COUNTIDD
from cteLikesTotal
Group by user_ID
)
select AVG (COUNTIDD) as AVGLPU
from cteTOTALIDD

-- Showing the number of likes per user
Select user_id, username, Count (likes.created_at) as LikeCount
From Likes
left Join users on likes.user_id=users.id
Group by user_id, username
Order by LikeCount DESC

-- Caculating the avrage likes per day (LPD)
with CTEAvgLPD as
(
Select Cast(created_at as Date) as CreateDate, Count (Cast(created_at as Date)) as LikeCount
From Likes
Group by Cast(created_at as Date)
)
Select Avg (LikeCount) as AVGLPD
From CTEAvgLPD

-- COMMENTS TABLE - ID, Text, User ID, Photo ID, Creation date
-- We have 1000 comments on photos in our page made by 77 of our users, only 35 photos on our page got comments, 
-- The greatest commenters on our site have 35 comments (5 users), the lowest one has 3 comments
-- We get 143 comments per day on avg We have an avarage of 13 comments per user
-- Each comment has a uniqe ID

Select *
from Comments

-- Caculating the avarage comments per user (CPU)
with cteComCount as
(
Select user_ID, count (distinct id) as ComCount
From comments
Group by user_id
)
select AVG (ComCount*1.00) as AVGCPU
from cteComCount

-- Showing the number of comments per user
Select user_id, username, Count (comments.created_at) as CommentCount
From comments
left Join users on comments.user_id=users.id
Group by user_id, username
Order by CommentCount DESC

-- Caculating the avrage comments per day (CPD)
with CTEAvgCPD as
(
Select Cast(created_at as Date) as CreateDate, Count (Cast(created_at as Date))*1.00 as CommentCount
From comments
Group by Cast(created_at as Date)
)
Select Avg (CommentCount) as AVGCPD
From CTEAvgCPD

-- PHOTO TAGS TABLE - PhotoID, TagID
-- This table shows all the tags given to a specific photo
-- On avarage each photo has 2.6 tags

Select *
From PhotoTags

-- Showing the number of tags per photo
Select photo_id, Count(tag_id) as TagCount
from PhotoTags
Group by photo_id

-- Showing the avarage tags per photo (TPP)
with cteTagCount as
(
Select photo_id, Count(tag_id) as TagCount
from PhotoTags
Group by photo_id
)
select AVG (TagCount*1.00) as AVGTPP
from cteTagCount

-- Influencers table - Influencer ID, Rank, Channel_info, Influence_score, posts, followers, avg_likes, engagement rate (60days), new post avg likes, total likes, country
-- We have 200 influencers from 25 known countries (and other un-registered places)
-- Our influencers have an avarage of 3.6 billion likes in total, new posts by our influencers get on avarage 1.12 million likes.
-- IID 168 - Rkive - Null at _60_day column
-- Some country lines have Null in them - Should change to Other

Select *
From Influencers

-- Caculating the Avarage number of likes per user (LPU)
With cteCountLikes as
(
Select InfluencerID, channel_info, Sum (Total_likes) as CountLikes
From Influencers
Group by InfluencerID, channel_info
)
Select Avg (CountLikes) as AVGLikes
From cteCountLikes

-- -- Caculating the Avarage number of new post likes per day (NPLPU)
With cteCountNewLikes as
(
Select InfluencerID, channel_info, Sum (new_post_avg_li) as CountNewLikes
From Influencers
Group by InfluencerID, channel_info
)
Select Avg (CountNewLikes) as AVGNewLikes
From cteCountNewLikes

-- FOLLOWN TABLE - Follower ID, Folowee ID, Creation date.
-- Our greatest influencers have 11 followers, our lowest influencers have 9
-- on avarage our influencers have 10 followers
Select *
From Follows

-- Count the numbers of followers per influencer
Select influencers.InfluencerID, influencers.channel_info ,Count (follower_id) as FollowNum
From Follows
Join Influencers on follows.followee_id=Influencers.InfluencerID
Group by influencers.InfluencerID, influencers.channel_info
Order by FollowNum DESC

-- Summery of tables in use in the previous code:

Select *
From comments

Select *
From Follows

Select *
From Influencers

Select *
From Likes

Select *
From Photos

Select *
from tags

Select *
From PhotoTags

Select *
From users

-- The following query is containing more complex KPIs and solutions

/* KPIS:
1. What is our average  post per day count (PPD)?
2. What is our active daily average like count? (average of the number of uniqe users who liked our photo)
3. What is our active daily average comment count? (average of the number of uniqe users who commented on our photo)
4. What is our average engagement rate per user? (Total number of comments & likes*100 devided by the total number of followers)
4. What is our active user count? (Number of users who engage with our contant)
5. What is our average engagement rate per day? (average engagement per day)
6. At what time of the day are we posting our photos?
7. Which are our best posts? (Which photos got the most engagement)
8. What is the best time to post? (What time of day did most of our users created engagement)
9. What piques most of our users interst? (certain tag? certain influencer?)
*/


-- 1. What is our avarage post per day count (PPD)? (Avarage of weekly user photo count devided daily)
With ctePhotoCount as
(
Select user_id, Count (distinct id) as PhotoCount
From Photos
Group by user_id
)
Select (AVG (Photocount)*1.00)/7
From ctePhotoCount
-- This result shows us that on avarage, half of our user pool (100 total users) uploads 1 photo

-- 2. What is our Active Daily Avarage Like count? (Avrage of the number of uniqe users who liked our photos)
;
with cteConcatPKCountLikes as
(
Select user_id, Count(distinct CONCAT (user_id, photo_id)) as LikeCount
From Likes
Group by user_id
)
Select AVG (LikeCount)*1.00/7 as ADAL
From cteConcatPKCountLikes
-- This avarage is from the 10 active users (out of 100) who actually used likes this week

-- 3. What is our Active Daily Avarage Comment count? (Avrage of the number of uniqe users who commented on our photo)
;
with cteCountcomments as
(
Select user_id, Count(id) as CommentCount
From comments
Group by user_id
)
Select AVG (CommentCount)*1.00/7 as ADAC
From cteCountcomments

-- 4.What is our avarage engagement rate per user? (Total number of comments & likes devided by the total number of users - A precentage)
;
with cteCountLikes as
(
Select user_id, Count(distinct CONCAT (user_id, photo_id)) as LikeCount
From Likes
Group by user_id
),
cteCountcomments as
(
Select user_id, Count(distinct id) as CommentCount
From comments
Group by user_id
),
cteTotals as
(
Select Count (distinct cteCountcomments.user_id) as TotalUsers, Sum(CommentCount)+Sum(LikeCount) as TotalENG
from cteCountcomments
left join cteCountLikes on cteCountcomments.user_id = cteCountLikes.user_id
)
Select (TotalENG*1.00/TotalUsers*1.00) as AvrageEngagmentPerUser
from cteTotals

;

-- 5. What is our avarage engagement rate per day? 
-- (Total number of comments & likes per day devided by the total number of users - A precentage)
with cteCountLikes as
(
Select Cast (created_at as date) as CDate, Count(distinct CONCAT (user_id, photo_id)) as LikeCount
From Likes
Group by Cast (created_at as date)
),
cteCountcomments as
(
Select Cast (created_at as date) as CDate, Count(distinct id) as CommentCount
From comments
Group by Cast (created_at as date)
),
cteTotals as
(
Select cteCountcomments.CDate, (CommentCount+LikeCount) as TotalENGPD
from cteCountcomments
Left join cteCountLikes on cteCountcomments.CDate = cteCountLikes.CDate
)
Select AVG (TotalENGPD)*1.00/100 as AvrageEngagementPerDayPerUser
from cteTotals
-- We can see that our AVG Engagment rate per day is around 2.85%

-- 6. At what time of the day are we posting our photos?
Select cast (created_at as time) as TimeOfDay, Count (cast (created_at as time)) as TimeCount
From Photos
Group by cast (created_at as time)
Order by TimeCount DESC

-- 7. Which are our best posts? (Which photos got the most engagement)
With ctePhotoLikes as
(
Select photo_id, count (photo_id) as LikeCount
from Likes
Group by photo_id
),
ctePhotoComments as
(
Select photo_id, count (photo_id) as CommentCount
from comments
Group by photo_id
)
Select top 10 Photos.*, cast (created_at as time) as PostTimeOfDay, isnull (LikeCount,0)+isnull(CommentCount, 0) as ENGCount
from Photos
Left Join ctePhotoLikes on photos.id=ctePhotoLikes.photo_id
Left Join ctePhotoComments on photos.id=ctePhotoComments.photo_id
Order by ENGCount DESC

-- 8. What is the best time to post in accordance with our audiance enegament? 
-- (What time of day did most of our users created engagement)
with cteLikeTime as
(
Select Cast (created_at as time) as ENGTime, Count (cast (created_at as time)) as TimeCount
from Likes
Group by Cast (created_at as time)
),
cteCommentTime as
(
Select Cast (created_at as time) as ENGTime, Count (cast (created_at as time)) as TimeCount
from comments
Group by Cast (created_at as time)
)
Select top 10 cteLikeTime.ENGTime, Sum(cteLikeTime.TimeCount+cteCommentTime.TimeCount) as ENGTimeCount
from cteLikeTime
Left Join cteCommentTime on cteLikeTime.ENGTime = cteCommentTime.ENGTime
Group by cteLikeTime.ENGTime
Order by ENGTimeCount DESC

-- 9. What tag piques most of our users interest?

With ctePhotoLikes as
(
Select photo_id, count (photo_id) as LikeCount
from Likes
Group by photo_id
),
ctePhotoComments as
(
Select photo_id, count (photo_id) as CommentCount
from comments
Group by photo_id
),
cteBest as
(
Select top 10 id, image_url, user_id, created_at, cast (created_at as time) as PostTimeOfDay, isnull (LikeCount,0)+isnull(CommentCount, 0) as ENGCount
from Photos
Left Join ctePhotoLikes on photos.id=ctePhotoLikes.photo_id
Left Join ctePhotoComments on photos.id=ctePhotoComments.photo_id
Order by ENGCount DESC
)
select top 3 tags.id, tag_name, count (tags.id) as TagCount
from cteBest
Join PhotoTags on cteBest.id = PhotoTags.photo_id
join tags on tags.id = PhotoTags.tag_id
group by tags.id, tag_name
order by TagCount DESC