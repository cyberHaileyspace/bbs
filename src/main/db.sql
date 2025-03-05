create table User_DB
(
    user_id       varchar2(50 char) primary key,
    user_pw       varchar2(50 char)  not null,
    user_name     varchar2(50 char)  not null,
    user_nickname varchar2(50 char)  not null unique,
    user_email    varchar2(100 char) not null unique,
    user_gender   varchar2(100 char) not null,
    user_image    varchar2(555 char) default null,
    user_date     timestamp          default SYSTIMESTAMP
);

drop table Post_DB cascade constraints purge;

insert into User_DB (user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)
values ('user03', 'password03', 'Taro', 'taro_nick03', 'taro03@email.com', 'male', 'profile_image.png');

select *
from User_DB;

ALTER TABLE User_DB
    MODIFY user_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

SELECT user_date, user_date AT TIME ZONE 'Asia/Seoul'
FROM User_DB;

ALTER TABLE Post_DB
    MODIFY post_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

ALTER TABLE Post_DB
    MODIFY post_update TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';



ALTER DATABASE SET TIME_ZONE = 'Asia/Seoul';

CREATE TABLE Post_DB
(
    user_id      varchar2(50 char)  not null,
    user_nickname varchar2(50 char)  not null unique,
    post_begin   varchar2(50 char)  not null,
    post_id      number generated always as identity primary key,
    post_title   varchar2(100 char) not null,
    post_context clob               not null,
    post_image   varchar2(555 char),
    post_date    timestamp default SYSTIMESTAMP,
    post_update  timestamp default SYSTIMESTAMP,
    constraint fk_post_user foreign key (user_id) references User_DB (user_id) ON DELETE CASCADE,
    constraint fk_post_user foreign key (user_nickname) references User_DB (user_nickname)
);

insert into Post_DB (user_id, post_begin, post_title, post_context, post_image, post_date, post_update) VALUES ('11', '서울', '11', '11','11');
/*업데이트 시스데이트 다시 넣기*/

select * from Post_DB;
