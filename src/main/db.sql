
-- ----------------------------------------------------------------------------------

CREATE TABLE Free_Post_DB
(
    user_nickname varchar2(50 char)  not null,
    post_category varchar2(50 char)  not null,
    post_menu     varchar2(50 char)  not null,
    post_id       number generated always as identity primary key,
    post_title    varchar2(100 char) not null,
    post_context  clob               not null,
    post_image    varchar2(555 char) default null,
    post_view     number             default null,
    post_like     number             default null,
    post_date     timestamp          default SYSTIMESTAMP,
    post_update   timestamp          default SYSTIMESTAMP,
    foreign key (user_nickname) references User_DB (user_nickname) ON DELETE CASCADE
);

insert into FREE_POST_DB (user_nickname, post_category, post_menu, post_title, post_context, post_image)
VALUES ('asas', '111', 'asd', 'asd', 'asdasd', null);

select * from FREE_POST_DB;


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

    UPDATE FREE_COMMENT
    SET c_writer = :NEW.user_nickname
    WHERE c_writer = :OLD.user_nickname;
END;

CREATE TABLE Free_comment (
                              c_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,  -- 댓글 고유 번호
                              post_id NUMBER NOT NULL,  -- 댓글이 속한 게시글 번호
                              c_writer VARCHAR2(100) NOT NULL,  -- 댓글 작성자
                              c_context CLOB NOT NULL,  -- 댓글 내용
                              c_like NUMBER DEFAULT 0,  -- 좋아요 기본값 0
                              c_date TIMESTAMP DEFAULT SYSTIMESTAMP,  -- 댓글 작성 시간 (기본값 현재 시간)
                              c_update TIMESTAMP,  -- 수정 시 UPDATE문에서 변경
                              FOREIGN KEY (post_id) REFERENCES FREE_POST_DB (post_id) ON DELETE CASCADE,
                              FOREIGN KEY (c_writer) REFERENCES User_DB (user_nickname) ON DELETE CASCADE
);

create sequence Free_comment;

insert into Free_comment (post_id, c_writer, c_context, c_date)values (22,'kim', '좋은글입니다.', systimestamp);
select * from Free_comment;




ALTER TABLE FREE_COMMENT
    MODIFY c_date TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';

ALTER TABLE FREE_COMMENT
    MODIFY c_update TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP AT TIME ZONE 'Asia/Seoul';



drop table Free_comment;

-- ----------------------------------------------------------------------


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

drop table Life_Post_DB cascade constraints purge;

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
    post_view     number             default null,
    post_like     number             default null,
    post_date     timestamp          default SYSTIMESTAMP,
    post_update   timestamp          default SYSTIMESTAMP,
    foreign key (user_nickname) references User_DB (user_nickname) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER update_nickname_trigger
    BEFORE UPDATE OF user_nickname
    ON User_DB
    FOR EACH ROW
BEGIN
    UPDATE ADMIN.FREE_POST_DB
    SET user_nickname = :NEW.user_nickname
    WHERE user_nickname = :OLD.user_nickname;
END;


insert into LIFE_POST_DB (user_nickname, post_category, post_menu, post_title, post_context, post_image)
VALUES ('456', '111', 'asd', 'asd', 'asdasd', null);

/*업데이트 시스데이트 다시 넣기*/

select *
from Life_Post_DB;

-- --------------------------------------------------------------

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