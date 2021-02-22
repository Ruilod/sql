USE vk;

-- Анализируем данные пользователей
SELECT * FROM users LIMIT 10;

-- Смотрим структуру таблицы пользователей
DESC users;

-- Приводим в порядок временные метки
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;  

-- Добавляем столбец username
ALTER TABLE users  ADD username varchar(30) NOT NULL  comment "Имя пользователя " AFTER id;

-- Добавим значения username
UPDATE users SET username = LOWER((SELECT last_name FROM profiles WHERE profiles.user_id = users.id));   


-- Смотрим структуру профилей
DESC profiles;

-- Анализируем данные
SELECT * FROM profiles LIMIT 10;

UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;  

-- Все таблицы
SHOW TABLES;

-- Смотрим структуру таблицы сообщений
DESC messages;

-- Анализируем данные
SELECT * FROM messages LIMIT 10;

-- Исправляем ссылки на пользователей
UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);

-- Смотрим структуру таблицы медиаконтента 
DESC media;

-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Обновляем ссылку на пользователя - владельца
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

ALTER TABLE media  ADD filename varchar(255) NOT NULL  comment "Путь к файлу " AFTER user_id;
ALTER TABLE media DROP filename; 

-- Обновляем ссылку на файл
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  '.',
  ((SELECT name FROM media_types WHERE media_types.id= media.media_type_id))
);

-- Обновляем размер файлов
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM profiles WHERE profiles.user_id = media.user_id),
  '"}');  

-- Возвращаем столбцу метеданных правильный тип, если нужно
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Смотрим структуру таблицы дружбы
DESC friendship;

-- Анализируем данные
SELECT * FROM friendship LIMIT 10;

-- Обновляем ссылки на друзей
UPDATE friendship SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100);

-- Исправляем случай когда user_id = friend_id
UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;
 
-- Анализируем данные 
SELECT * FROM friendship_statuses;

-- Очищаем таблицу
TRUNCATE friendship_statuses;

-- Вставляем значения статусов дружбы
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 
-- Обновляем ссылки на статус 
UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3); 

-- Смотрим структуру таблицы групп
DESC communities;

-- Анализируем данные
SELECT * FROM communities;

-- Удаляем часть групп
DELETE FROM communities WHERE id > 20;

-- Анализируем таблицу связи пользователей и групп
SELECT * FROM communities_users;

DESC communities_users;

-- Обновляем значения community_id и user_id
UPDATE communities_users SET
  user_id = FLOOR(1 + RAND() * 100),
  community_id = FLOOR(1 + RAND() * 20);