desc video_likes;

show tables;

-- user's videos
SELECT * from videos where user_id = 1;

-- User's video likes
SELECT  COUNT(video_likes.user_id) as total_video_likes , users.id 
from users join video_likes on users.id = video_likes.user_id where video_likes.is_like = 1 group by video_likes.user_id order by users.id;

-- total comment's likes
SELECT SUM(total_comments_likes) FROM (SELECT  COUNT(comments_likes.user_id) as total_comments_likes , users.id 
from users join comments_likes on users.id = comments_likes.user_id where comments_likes.is_like = 1 group by comments_likes.user_id order by users.id) as tblfrsum;


-- the most active users
CREATE VIEW activity_top AS select users.id,
	COUNT(distinct video_likes.id) +
	COUNT(distinct posts_likes.id) +
	COUNT(distinct comments_likes.id) +
	COUNT(distinct comments.id) +
	COUNT(distinct videos.id) +
	COUNT(distinct posts.id) as total_activity
	from users 
		left join video_likes on users.id = video_likes.user_id
		left join posts_likes on users.id = posts_likes.user_id
		left join comments_likes on users.id = comments_likes.user_id
		left join comments on users.id = comments.user_id
		left join videos on users.id = videos.user_id
		left join posts on users.id = posts.user_id
	group by users.id
	order by total_activity DESC
	limit 10;
SELECT * from activity_top;


-- video top
create view top_videos AS (select videos.id, count(distinct views.id) as Views
	from videos left join views on videos.id = views.target_id
	group by videos.id order by Views DESC);
SELECT * from top_videos;
		









