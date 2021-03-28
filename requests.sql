desc video_likes;

show tables;


-- User's video likes
SELECT  COUNT(video_likes.user_id) as total_video_likes , users.id 
from users join video_likes on users.id = video_likes.user_id where video_likes.is_like = 1 group by video_likes.user_id order by users.id;









