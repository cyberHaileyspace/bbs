ALTER TABLE User_DB
    MODIFY user_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

insert into User_DB (user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)
values ('user03', 'password03', 'Taro', 'taro_nick03', 'taro03@email.com', 'male', 'profile_image.png');

select *
from User_DB;

SELECT user_date, user_date AT TIME ZONE 'Asia/Seoul'
FROM User_DB;

ALTER DATABASE SET TIME_ZONE = 'Asia/Seoul';

CREATE TABLE Free_Post_DB
(
    user_nickname varchar2(50 char)  not null,
    post_category varchar2(50 char)  not null,
    post_menu     varchar2(50 char)  not null,
    post_id       number generated always as identity primary key,
    post_title    varchar2(100 char) not null,
    post_context  clob               not null,
    post_image    varchar2(555 char) default null,
    post_view     number             default 0,
    post_like     number             default 0,
    post_date     timestamp          default SYSTIMESTAMP,
    post_update   timestamp          default SYSTIMESTAMP,
    foreign key (user_nickname) references User_DB (user_nickname) ON DELETE CASCADE
);

insert into FREE_POST_DB (user_nickname, post_category, post_menu, post_title, post_context, post_image)
VALUES ('asas', '111', 'asd', 'asd', 'asdasd', null);

select *
from FREE_POST_DB;

ALTER TABLE FREE_POST_DB
    MODIFY post_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

ALTER TABLE FREE_POST_DB
    MODIFY post_update TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

CREATE OR REPLACE TRIGGER update_nickname_trigger
    BEFORE UPDATE OF user_nickname
    ON User_DB
    FOR EACH ROW
BEGIN
    UPDATE FREE_POST_DB
    SET user_nickname = :NEW.user_nickname
    WHERE user_nickname = :OLD.user_nickname;

    UPDATE Life_reply
    SET c_writer = :NEW.user_nickname
    WHERE c_writer = :OLD.user_nickname;
END;

drop table FREE_POST_DB;

CREATE TABLE Free_reply (
                              r_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,  -- 댓글 고유 번호
                              post_id NUMBER NOT NULL,  -- 댓글이 속한 게시글 번호
                              r_writer VARCHAR2(100) NOT NULL,  -- 댓글 작성자
                              r_context CLOB NOT NULL,  -- 댓글 내용
                              r_like NUMBER DEFAULT 0,  -- 좋아요 기본값 0
                              r_date TIMESTAMP DEFAULT SYSTIMESTAMP,  -- 댓글 작성 시간 (기본값 현재 시간)
                              r_update TIMESTAMP,  -- 수정 시 UPDATE문에서 변경
                              FOREIGN KEY (post_id) REFERENCES FREE_POST_DB (post_id) ON DELETE CASCADE,
                              FOREIGN KEY (r_writer) REFERENCES User_DB (user_nickname) ON DELETE CASCADE
);

create sequence Free_reply;

insert into Free_reply (post_id, r_writer, r_context, r_date)values (2,'kim', '좋은글입니다.', systimestamp);

select * from Free_reply;

ALTER TABLE Free_reply
    MODIFY r_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

ALTER TABLE Free_reply
    MODIFY r_update TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

drop table Free_reply;

----------------------------------------------------------------

CREATE TABLE Life_reply (
                            r_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,  -- 댓글 고유 번호
                            post_id NUMBER NOT NULL,  -- 댓글이 속한 게시글 번호
                            r_writer VARCHAR2(100) NOT NULL,  -- 댓글 작성자
                            r_context CLOB NOT NULL,  -- 댓글 내용
                            r_like NUMBER DEFAULT 0,  -- 좋아요 기본값 0
                            r_date TIMESTAMP DEFAULT SYSTIMESTAMP,  -- 댓글 작성 시간 (기본값 현재 시간)
                            r_update TIMESTAMP,  -- 수정 시 UPDATE문에서 변경
                            FOREIGN KEY (post_id) REFERENCES FREE_POST_DB (post_id) ON DELETE CASCADE,
                            FOREIGN KEY (r_writer) REFERENCES User_DB (user_nickname) ON DELETE CASCADE
);

create sequence Life_reply;

insert into Life_reply (post_id, r_writer, r_context, r_date)values (42,'567', '좋은글입니다.', systimestamp);

select * from Life_reply;

ALTER TABLE Life_reply
    MODIFY r_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

ALTER TABLE Life_reply
    MODIFY r_update TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

drop table Life_reply;

----------------------------------------------------------------

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

drop table Free_Post_DB cascade constraints purge;

insert into User_DB (user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)
values ('user03', 'password03', 'Taro', 'taro_nick03', 'taro03@email.com', 'male', 'profile_image.png');
insert into User_DB (user_id, user_pw, user_name, user_nickname, user_email, user_gender, user_image)
values ('user02', 'password03', 'Taro', 'taro_nick02', 'sh04070@email.com', 'male', 'profile_image.png');

select *
from User_DB;

ALTER TABLE User_DB
    MODIFY user_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

SELECT user_date, user_date AT TIME ZONE 'Asia/Seoul'
FROM User_DB;

CREATE TABLE Life_Post_DB
(
    user_nickname varchar2(50 char)  not null,
    post_category varchar2(50 char)  not null,
    post_menu     varchar2(50 char)  not null,
    post_id       number generated always as identity primary key,
    post_title    varchar2(100 char) not null,
    post_context  clob               not null,
    post_image    varchar2(555 char) default null,
    post_view     number             default 0,
    post_like     number             default 0,
    post_date     timestamp          default SYSTIMESTAMP,
    post_update   timestamp          default SYSTIMESTAMP,
    foreign key (user_nickname) references User_DB (user_nickname) ON DELETE CASCADE
);

drop table Life_Post_DB cascade constraints purge;

CREATE OR REPLACE TRIGGER update_nickname_trigger
    BEFORE UPDATE OF user_nickname
    ON User_DB
    FOR EACH ROW
BEGIN
    UPDATE ADMIN.LIFE_POST_DB
    SET user_nickname = :NEW.user_nickname
    WHERE user_nickname = :OLD.user_nickname;
END;

ALTER TABLE Life_Post_DB
    MODIFY post_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

insert into FREE_POST_DB (user_nickname, post_category, post_menu, post_title, post_context, post_image)
VALUES ('456', '111', 'asd', 'asd', 'asdasd', null);

insert into LIFE_POST_DB (user_nickname, post_category, post_menu, post_title, post_context, post_image)
VALUES ('567', '111', 'asd', 'asd', 'asdasd', null);

/*업데이트 시스데이트 다시 넣기*/

select *
from Free_Post_DB;

select *
from Life_Post_DB;

update Life_Post_DB set post_view = 0 where post_id = 1;

----------------------------------------------------------------

CREATE TABLE Tourist_Spot_DB
(
    spot_id      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- 관광지 ID (기본키, 자동 증가)
    spot_name    VARCHAR2(255) NOT NULL,                              -- 관광지 이름
    spot_address VARCHAR2(500) NOT NULL,                              -- 주소
    spot_desc    CLOB,                                                -- 설명 (긴 텍스트 저장)
    spot_contact VARCHAR2(50),                                        -- 문의 및 안내(연락처)
    spot_closed  VARCHAR2(255),                                       -- 쉬는 날
    spot_hours   VARCHAR2(255),                                       -- 이용 시간
    spot_image   VARCHAR2(500),                                       -- 이미지 URL
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP                       -- 등록 날짜 (기본값: 현재 시간)
);

select *
from Tourist_Spot_DB;

drop table Life_Post_DB cascade constraints purge;

create table tourlist_reply(
                               c_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,  -- 댓글 고유 번호
                               contentid NUMBER NOT NULL,  -- 댓글이 속한 게시글 번호
                               c_writer VARCHAR2(100) NOT NULL,  -- 댓글 작성자
                               c_context CLOB NOT NULL,  -- 댓글 내용
                               c_like NUMBER DEFAULT 0,  -- 좋아요 기본값 0
                               c_date TIMESTAMP DEFAULT SYSTIMESTAMP,  -- 댓글 작성 시간 (기본값 현재 시간)
                               c_update TIMESTAMP  -- 수정 시 UPDATE문에서 변경
);

insert into tourlist_reply (contentid, c_writer, c_context, c_date) values ('264570','수현호','여기 물가 무서워...',sysdate);

select *
from tourlist_reply;
