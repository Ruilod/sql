-- Подсчет кол-ва лайков разных полов

SELECT IF((SELECT COUNT(*) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE sex = 'man '))>
(SELECT COUNT(*) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE sex = 'woman ')),
'men','women') as 'More likes have';

-- общее кол-во лайков самым молодым
SELECT COUNT(*) FROM likes WHERE target_id IN 
(SELECT id FROM media WHERE user_id IN(SELECT * FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) subtable));

