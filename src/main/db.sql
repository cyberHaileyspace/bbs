create table User_DB
(
    user_id       varchar2(50 char)  primary key,
    user_pw       varchar2(50 char)  not null,
    user_name     varchar2(50 char)  not null,
    user_nickname varchar2(50 char)  not null unique,
    user_email    varchar2(100 char) not null unique,
    user_gender   varchar2(100 char) not null,
    user_image    varchar2(555 char) default null,
    user_date     timestamp          default SYSTIMESTAMP
);

drop table User_DB cascade constraints purge;

insert into User_DB (user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)
values ('user01', 'password01', 'Taro', 'taro_nick01', 'taro01@email.com', 'male', 'profile_image.png');

select * from User_DB;

ALTER TABLE User_DB MODIFY user_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

SELECT user_date, user_date AT TIME ZONE 'Asia/Seoul' FROM User_DB;

ALTER DATABASE SET TIME_ZONE = 'Asia/Seoul';
