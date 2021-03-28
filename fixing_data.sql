USE YT;


UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;  

DESC profiles;

SELECT * FROM profiles LIMIT 10;

UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;  


SHOW TABLES;

SELECT * FROM follows LIMIT 10;


UPDATE follows SET
  user_id = FLOOR(1 + RAND() * 100),
  follower_id = FLOOR(1 + RAND() * 100);
 
UPDATE comments SET
  user_id = FLOOR(1 + RAND() * 100),
  target_video_id = FLOOR(1 + RAND() * 500),
  target_post_id = FLOOR(1 + RAND() * 300);
 
UPDATE comments_likes SET
  user_id = FLOOR(1 + RAND() * 100),
  target_id = FLOOR(1 + RAND() * 200);
 
 UPDATE posts SET
  user_id = FLOOR(1 + RAND() * 100);
 
 UPDATE posts_likes SET
  user_id = FLOOR(1 + RAND() * 100),
  target_id = FLOOR(1 + RAND() * 300);
 
 UPDATE views SET
  user_id = FLOOR(1 + RAND() * 100),
  target_id = FLOOR(1 + RAND() * 500);
 

DESC videos;


SELECT * FROM videos LIMIT 10;

UPDATE videos SET user_id = FLOOR(1 + RAND() * 100);

DESC video_likes;
desc videos;

-- Обновляем vid likes
UPDATE videos, v SET dislikes_count = likes where videos.id = v.id;

create or replace view v as select videos.id, count(distinct video_likes.id) as likes
	from videos left join video_likes on videos.id = video_likes.target_id
	where not is_like
	group by videos.id;


-- Заполняем metadata
UPDATE videos SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM profiles WHERE profiles.user_id = videos.user_id),
  '"}');  


ALTER TABLE videos ADD COLUMN metadata JSON after tags;

UPDATE follows SET follower_id = follower_id + 1 WHERE user_id = follower_id;

CREATE INDEX users_email_idx ON users(email);
CREATE INDEX users_phone_idx ON users(phone);
CREATE INDEX videos_name_idx ON videos(video_name);
CREATE INDEX videos_tags_idx ON videos(tags);


  
 
 
 