-- Подсчет кол-ва лайков разных полов

SELECT IF((SELECT COUNT(*) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE sex = 'man '))>
(SELECT COUNT(*) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE sex = 'woman ')),
'men','women') as 'More likes have';

-- общее кол-во лайков самым молодым
SELECT COUNT(*) FROM likes WHERE target_id IN 
(SELECT id FROM media WHERE user_id IN(SELECT * FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) subtable));

-- Выборка наименее активных пользователей 
SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = profiles.user_id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = profiles.user_id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = profiles.user_id) AS activity
	  FROM profiles 
	  ORDER BY activity
	  LIMIT 10;	