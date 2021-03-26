DROP DATABASE IF EXISTS YT;
CREATE DATABASE YT;
USE YT;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
	email varchar(100) NOT NULL COMMENT 'Почта',
  phone varchar(20) NOT NULL COMMENT 'Телефон',
  passwd varchar (100) NOT NULL COMMENT 'password',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id),
  UNIQUE KEY email (email),
  UNIQUE KEY phone (phone)
) comment 'Table of login info';

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id INT unsigned NOT NULL PRIMARY KEY comment'User\'s ID',
	first_name varchar(30) NOT NULL comment 'Name of a user',
	last_name varchar(30) NOT NULL comment 'Last name of a user',
	description text comment 'Description of the channel',
	channel_name varchar(100) UNIQUE NOT NULL comment 'Name of a channel',
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	constraint profiles_user_id_fk foreign key (user_id) references users(id) ON DELETE CASCADE
	) comment 'profiles/channel info';

drop table if exists follow_status;
create table follow_status(
	id TINYINT unsigned primary key auto_increment not null,
	name varchar(20) unique comment 'follower/black list/Super follower',
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
	);

DROP TABLE IF exists follows;
CREATE TABLE follows(
	user_id INT unsigned NOT Null,
	follower_id INT unsigned NOT NULL,
	relationship_status TINYINT unsigned,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	PRIMARY KEY (user_id, follower_id),
	constraint follows_user_id_fk foreign key (user_id) references users(id) ON DELETE CASCADE,
	constraint follows_follower_id_fk foreign key (follower_id) references users(id) ON DELETE CASCADE,
	constraint follows_relationship_status_fk foreign key (relationship_status) references follow_status(id)
	);


drop table if exists videos;
create table videos(
	id int unsigned not null AUTO_INCREMENT,
	user_id int unsigned not null,
	video_name varchar(100) not null,
	tags varchar(20),
	likes_count int,
	dislikes_count int,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	constraint videos_user_id_fk foreign key (user_id) references users(id) ON DELETE CASCADE,
	primary key (id)
	);
	
drop table if exists video_likes;
create table video_likes(
	id bigint unsigned not null AUTO_INCREMENT,
	user_id int unsigned not null,
	target_id int unsigned not null,
	is_like BOOL,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	primary key (id),
	constraint video_likes_user_id_fk foreign key (user_id) references users(id),
	constraint video_likes_target_id_fk foreign key (target_id) references videos(id)
	);


drop table if exists posts;
CREATE table posts(
	id int unsigned not null AUTO_INCREMENT,
	user_id int unsigned not null,
	post_text text not null,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	constraint posts_user_id_fk foreign key (user_id) references users(id) ON DELETE CASCADE,
	primary key (id)
	);

drop table if exists posts_likes;
create table posts_likes(
	id bigint unsigned not null AUTO_INCREMENT,
	user_id int unsigned not null,
	target_id int unsigned not null,
	is_like BOOL,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	primary key (id),
	constraint posts_likes_user_id_fk foreign key (user_id) references users(id),
	constraint posts_likes_target_id_fk foreign key (target_id) references posts(id) ON DELETE CASCADE
	);


drop table if exists comments;
create table comments(
	id bigint unsigned not null primary key AUTO_INCREMENT,
	user_id int unsigned not null,
	comment_text varchar(300) not null,
	target_video_id int unsigned,
	target_post_id int unsigned,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	constraint comments_user_id_fk foreign key (user_id) references users(id),
	constraint comments_target_video_id_fk foreign key (target_video_id) references videos(id) ON DELETE CASCADE,
	constraint comments_target_post_id_fk foreign key (target_post_id) references posts(id) ON DELETE CASCADE
	);


drop table if exists comments_likes;
create table comments_likes(
	id bigint unsigned not null AUTO_INCREMENT,
	user_id int unsigned not null,
	target_id bigint unsigned not null,
	is_like BOOL,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	primary key (id),
	constraint comments_likes_user_id_fk foreign key (user_id) references users(id),
	constraint comments_likes_target_id_fk foreign key (target_id) references comments(id) ON DELETE CASCADE
	);

drop table if exists views;
create table views(
	id bigint unsigned not null AUTO_INCREMENT,
	user_id int unsigned not null,
	target_id int unsigned not null,
	created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
	primary key (id),
	constraint views_user_id_fk foreign key (user_id) references users(id),
	constraint views_target_id_fk foreign key (target_id) references videos(id) ON DELETE CASCADE
	);


