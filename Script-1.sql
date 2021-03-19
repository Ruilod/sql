-- Подсчет кол-ва лайков разных полов

SELECT profiles.sex, COUNT(likes.id) AS total_likes
  FROM likes JOIN profiles ON likes.user_id = profiles.user_id
    GROUP BY profiles.sex ORDER BY total_likes DESC
    LIMIT 1;
    
-- общее кол-во лайков 10 самым молодым

SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(likes.id) AS got_likes 
      FROM profiles
        LEFT JOIN likes ON likes.target_id = profiles.user_id AND target_type_id = 2
      GROUP BY profiles.user_id ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;   

-- наименее активные пользователи 

SELECT users.id,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) + 
  COUNT(DISTINCT media.id) AS activity 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY activity
  LIMIT 10;
  
 