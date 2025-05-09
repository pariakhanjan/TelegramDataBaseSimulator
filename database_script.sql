DROP DATABASE IF EXISTS mychatdb CASCADE;
CREATE DATABASE mychatdb;
USE mychatdb;

--------------------------------------------------
-- 1. تعریف جداول
--------------------------------------------------

-- جدول Auth
CREATE TABLE Auth (
    auth_id       INT PRIMARY KEY,
    verify_password  BOOL,
    verify_phone     BOOL
);

-- جدول Users
CREATE TABLE Users (
    user_id   INT PRIMARY KEY,
    is_premium BOOL,
    auth_id   INT,
    CONSTRAINT fk_auth
       FOREIGN KEY (auth_id) REFERENCES Auth(auth_id)
);

-- جدول contact
CREATE TABLE contact (
    phone_number   DECIMAL(11, 0) PRIMARY KEY,
    public_photo   TEXT,
    bio            TEXT,
    first_name     TEXT,
    last_name      TEXT,
    story1         TEXT,
    story2         TEXT,
    story3         TEXT,
    user_name      TEXT,
    last_seen      TIMESTAMP,
    date_of_birth  DATE,
    user_id        INT,
    contact_id     INT,
    CONSTRAINT fk_contact_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_contact_user1 FOREIGN KEY (contact_id) REFERENCES Users(user_id)
);

-- جدول dates
CREATE TABLE dates (
    date_id   INT PRIMARY KEY,
    year      INT,
    month     INT,
    day       INT
);

-- جدول Folder
CREATE TABLE Folder (
    folder_id    INT PRIMARY KEY,
    notif_number INT,
    icon         TEXT,
    name         TEXT,
    phone_number DECIMAL(11, 0),
    CONSTRAINT fk_folder_contact
       FOREIGN KEY (phone_number) REFERENCES contact(phone_number)
);

-- جدول private_photo
CREATE TABLE private_photo (
    photo_id     SERIAL PRIMARY KEY,
    phone_number DECIMAL(11, 0),
    CONSTRAINT fk_private_photo_contact
       FOREIGN KEY (phone_number) REFERENCES contact(phone_number)
);

-- جدول Storage
CREATE TABLE Storage (
    address     INT PRIMARY KEY,
    remove_time DATE,
    cache       INT,
    limit_val   INT,
    type        TEXT
);

-- جدول Premium
CREATE TABLE Premium (
    pay_id      INT PRIMARY KEY,
    start_date  DATE,
    amount      INT,
    method      TEXT,
    expire_date DATE,
    user_id     INT,
    CONSTRAINT fk_premium_user
       FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- جدول Bot
CREATE TABLE Bot (
    chat_id         INT,
    bot_id          INT,
    is_archive      BOOL,
    make_phone_number  DECIMAL(11, 0),
    de_phone_number    DECIMAL(11, 0),
    bio             TEXT,
    picture         TEXT,
    member_count    INT,
    link            TEXT,
    name            TEXT,
    PRIMARY KEY (chat_id, bot_id),
    CONSTRAINT fk_bot_make_contact FOREIGN KEY (make_phone_number) REFERENCES contact(phone_number),
    CONSTRAINT fk_bot_de_contact   FOREIGN KEY (de_phone_number) REFERENCES contact(phone_number)
);

-- جدول channel
CREATE TABLE channel (
    chat_id         INT PRIMARY KEY,
    is_archive      BOOL,
    make_phone_number  DECIMAL(11, 0),
    de_phone_number    DECIMAL(11, 0),
    start_date      DATE,
    bio             TEXT,
    picture         TEXT,
    member_count    INT,
    link            TEXT,
    name            TEXT,
    is_private      BOOL,
    group_id        INT,
    CONSTRAINT fk_channel_make_contact FOREIGN KEY (make_phone_number) REFERENCES contact(phone_number),
    CONSTRAINT fk_channel_de_contact   FOREIGN KEY (de_phone_number) REFERENCES contact(phone_number)
);

-- جدول Member
CREATE TABLE Member (
    phone_number   DECIMAL(11, 0) PRIMARY KEY,
    public_photo   TEXT,
    bio            TEXT,
    first_name     TEXT,
    last_name      TEXT,
    story1         TEXT,
    story2         TEXT,
    story3         TEXT,
    user_name      TEXT,
    last_seen      TIMESTAMP,
    date_of_birth  DATE,
    user_id        INT,
    chat_id        INT,
    CONSTRAINT fk_member_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- جدول Admin
CREATE TABLE Admins (
    phone_number   DECIMAL(11, 0) PRIMARY KEY,
    public_photo   TEXT,
    bio            TEXT,
    first_name     TEXT,
    last_name      TEXT,
    story1         TEXT,
    story2         TEXT,
    story3         TEXT,
    user_name      TEXT,
    last_seen      TIMESTAMP,
    date_of_birth  DATE,
    user_id        INT,
    chat_id        INT,
    CONSTRAINT fk_admin_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- جدول personal
CREATE TABLE personal (
    phone_number   DECIMAL(11, 0),
    chat_id        INT,
    public_photo   TEXT,
    bio            TEXT,
    first_name     TEXT,
    last_name      TEXT,
    story1         TEXT,
    story2         TEXT,
    story3         TEXT,
    user_name      TEXT,
    last_seen      TIMESTAMP,
    date_of_birth  DATE,
    is_archive     BOOL,
    make_phone_number DECIMAL(11, 0),
    de_phone_number   DECIMAL(11, 0),
    user_id        INT,
    PRIMARY KEY (phone_number, chat_id),
    CONSTRAINT fk_personal_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_personal_make_contact FOREIGN KEY (make_phone_number) REFERENCES contact(phone_number),
    CONSTRAINT fk_personal_de_contact   FOREIGN KEY (de_phone_number) REFERENCES contact(phone_number)
);

-- جدول Owner
CREATE TABLE Owners (
    phone_number   DECIMAL(11, 0) PRIMARY KEY,
    public_photo   TEXT,
    bio            TEXT,
    first_name     TEXT,
    last_name      TEXT,
    story1         TEXT,
    story2         TEXT,
    story3         TEXT,
    user_name      TEXT,
    last_seen      TIMESTAMP,
    date_of_birth  DATE,
    user_id        INT,
    chat_id        INT,
    CONSTRAINT fk_owner_user FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- جدول Group
CREATE TABLE Groupss (
    chat_id         INT PRIMARY KEY,
    is_archive      BOOL,
    make_phone_number  DECIMAL(11, 0),
    de_phone_number    DECIMAL(11, 0),
    start_date      DATE,
    bio             TEXT,
    picture         TEXT,
    member_count    INT,
    link            TEXT,
    name            TEXT,
    is_private      BOOL,
    is_super_group  BOOL,
    CONSTRAINT fk_group_make_contact FOREIGN KEY (make_phone_number) REFERENCES contact(phone_number),
    CONSTRAINT fk_group_de_contact   FOREIGN KEY (de_phone_number) REFERENCES contact(phone_number)
);

--------------------------------------------------
-- جداول پیام
--------------------------------------------------

-- جدول Text
CREATE TABLE text_message (
    message_id    INT PRIMARY KEY,
    emoji         TEXT,
    content       TEXT,
    timed         INT,
    is_once_seen  BOOL,
    size          INT,
    link          TEXT,
    is_pinned     BOOL,
    msg_date      TIMESTAMP,
    user_id       INT,
    address       INT,
    reply_message_id INT,
    de_chat_id    INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    format_id     INT,
    CONSTRAINT fk_text_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_text_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Sticker
CREATE TABLE Sticker (
    message_id    INT PRIMARY KEY,
    codes         INT,
    timed         INT,
    is_once_seen  BOOL,
    size          INT,
    link          TEXT,
    is_pinned     BOOL,
    msg_date      TIMESTAMP,
    user_id       INT,
    address       INT,
    reply_message_id INT,
    de_chat_id    INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    make_user_id  INT,
    pack_id       INT,
    CONSTRAINT fk_sticker_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_sticker_address FOREIGN KEY (address) REFERENCES Storage(address)
);

--------------------------------------------------
-- جداول Reaction, Option, Bot_Option, Format, Pack و ...
--------------------------------------------------

-- جدول Reaction
CREATE TABLE Reaction (
    reaction_id SERIAL PRIMARY KEY,
    message_id  INT,
    CONSTRAINT fk_reaction_message FOREIGN KEY (message_id) REFERENCES text_message(message_id)
);

-- جدول Poll
CREATE TABLE poll (
    message_id    INT PRIMARY KEY,
    name         TEXT,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_poll_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_poll_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Option
CREATE TABLE Option_message (
    option_id   SERIAL PRIMARY KEY,
    message_id  INT,
    quantity    INT,
    CONSTRAINT fk_option_message FOREIGN KEY (message_id) REFERENCES Poll(message_id)
);

-- جدول Location
CREATE TABLE Locations (
    message_id    INT PRIMARY KEY,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_location_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_location_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول File
CREATE TABLE File (
    message_id    INT PRIMARY KEY,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_file_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_file_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Picture
CREATE TABLE Picture (
    message_id    INT PRIMARY KEY,
    quality      INT,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_picture_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_picture_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Gif
CREATE TABLE Gif (
    message_id    INT PRIMARY KEY,
    codes         INT,
    duration     INT,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_gif_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_gif_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Music
CREATE TABLE Music (
    message_id    INT PRIMARY KEY,
    duration     INT,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_music_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_music_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Voice
CREATE TABLE Voice (
    message_id    INT PRIMARY KEY,
    duration     INT,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_voice_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_voice_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Video
CREATE TABLE Video (
    message_id    INT PRIMARY KEY,
    duration     INT,
    quality      INT,
    timed        INT,
    is_once_seen BOOL,
    size         INT,
    link         TEXT,
    is_pinned    BOOL,
    msg_date     TIMESTAMP,
    user_id      INT,
    address      INT,
    reply_message_id INT,
    de_chat_id   INT,
    se_and_re_chat_id INT,
    forward_chat_id   INT,
    edit_chat_id      INT,
    CONSTRAINT fk_video_user FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT fk_video_address FOREIGN KEY (address) REFERENCES Storage(address)
);

-- جدول Bot_Option
CREATE TABLE Bot_Option (
    chat_id INT,
    bot_id  INT,
    PRIMARY KEY (chat_id, bot_id),
    CONSTRAINT fk_bot_option_bot FOREIGN KEY (chat_id, bot_id)
       REFERENCES Bot(chat_id, bot_id)
);

-- جدول Format
CREATE TABLE Format (
    format_id INT PRIMARY KEY,
    bold      BOOL,
    italic    BOOL,
    spoiler   BOOL
);

-- جدول Pack
CREATE TABLE Pack (
    pack_id   INT PRIMARY KEY,
    pack_name TEXT
);

--------------------------------------------------
-- درج نمونه داده‌ها (۵ رکورد برای هر جدول)
--------------------------------------------------

-- داده‌های جدول Auth
INSERT INTO Auth (auth_id, verify_password, verify_phone) VALUES
  (1, TRUE, TRUE),
  (2, FALSE, TRUE),
  (3, TRUE, FALSE),
  (4, TRUE, TRUE),
  (5, FALSE, FALSE);

-- داده‌های جدول Users
INSERT INTO Users (user_id, is_premium, auth_id) VALUES
  (101, TRUE, 1),
  (102, FALSE, 2),
  (103, TRUE, 3),
  (104, FALSE, 4),
  (105, TRUE, 5);

-- داده‌های جدول contact
INSERT INTO contact (phone_number, public_photo, bio, first_name, last_name, story1, story2, story3, user_name, last_seen, date_of_birth, user_id, contact_id) VALUES
  (9891000001, 'photo1.jpg', 'bio1', 'Mohammad', 'Ahmadi', 's1', 's2', 's3', 'mohammad', NOW(), '1990-01-01', 101, 103),
  (9891000002, 'photo2.jpg', 'bio2', 'Ali', 'Rezayi', 's1', 's2', 's3', 'ali', NOW(), '1992-02-02', 102, 103),
  (9891000004, 'photo1.jpg', 'bio1', 'Mohammad', 'Ahmadi', 's1', 's2', 's3', 'mohammad', NOW(), '1990-01-01', 101, 104),
  (9891000006, 'photo2.jpg', 'bio2', 'Ali', 'Rezayi', 's1', 's2', 's3', 'ali', NOW(), '1992-02-02', 102, 105),
  (9891000003, 'photo3.jpg', 'bio3', 'Hossein', 'Karimi', 's1', 's2', 's3', 'hossein', NOW(), '1991-03-03', 103, 101),
  (09120000008, 'photo4.jpg', 'bio4', 'Sara', 'Mohseni', 's1', 's2', 's3', 'sara', NOW(), '1993-04-04', 104, 102),
  (9891000005, 'photo5.jpg', 'bio5', 'Reza', 'Nazari', 's1', 's2', 's3', 'reza', NOW(), '1994-05-05', 105, 103);

-- داده‌های جدول dates
INSERT INTO dates (date_id, year, month, day) VALUES
  (1, 2025, 1, 1),
  (2, 2025, 1, 2),
  (3, 2025, 1, 3),
  (4, 2025, 1, 4),
  (5, 2025, 1, 5);

-- داده‌های جدول Folder
INSERT INTO Folder (folder_id, notif_number, icon, name, phone_number) VALUES
  (1, 5, 'icon1.png', 'Folder1', 9891000001),
  (2, 2, 'icon2.png', 'Folder2', 9891000002),
  (3, 3, 'icon3.png', 'Folder3', 9891000003),
  (4, 1, 'icon4.png', 'Folder4', 09120000008),
  (5, 0, 'icon5.png', 'Folder5', 9891000005);

-- داده‌های جدول private_photo
INSERT INTO private_photo (phone_number) VALUES
  (9891000001),
  (9891000002),
  (9891000003),
  (09120000008),
  (9891000005);

-- داده‌های جدول Storage
INSERT INTO Storage (address, remove_time, cache, limit_val, type) VALUES
  (1001, '2025-02-01', 50, 500, 'image'),
  (1002, '2025-03-01', 30, 300, 'video'),
  (1003, '2025-04-01', 20, 200, 'file'),
  (1004, '2025-05-01', 40, 400, 'audio'),
  (1005, '2025-06-01', 10, 100, 'document');

-- داده‌های جدول Premium
INSERT INTO Premium (pay_id, start_date, amount, method, expire_date, user_id) VALUES
  (1, '2025-01-01', 100, 'credit', '2025-07-01', 101),
  (2, '2025-01-15', 150, 'paypal', '2025-08-15', 102),
  (3, '2025-02-01', 200, 'credit', '2025-09-01', 103),
  (4, '2025-02-15', 250, 'debit', '2025-10-15', 104),
  (5, '2025-03-01', 300, 'paypal', '2025-11-01', 105);

-- داده‌های جدول Bot
INSERT INTO Bot (chat_id, bot_id, is_archive, make_phone_number, de_phone_number, bio, picture, member_count, link, name) VALUES
  (201, 1, FALSE, 9891000001, 9891000002, 'Bot bio 1', 'bot1.jpg', 100, 'link1', 'first_bot'),
  (202, 2, TRUE, 9891000002, 9891000003, 'Bot bio 2', 'bot2.jpg', 200, 'link2', 'second_bot'),
  (203, 3, FALSE, 9891000003, 09120000008, 'Bot bio 3', 'bot3.jpg', 300, 'link3', 'third_bot'),
  (204, 4, TRUE, 09120000008, 9891000005, 'Bot bio 4', 'bot4.jpg', 400, 'link4', 'fourth_bot'),
  (205, 5, FALSE, 9891000005, 9891000001, 'Bot bio 5', 'bot5.jpg', 500, 'link5', 'fifth_bot');

-- داده‌های جدول channel
INSERT INTO channel (chat_id, is_archive, make_phone_number, de_phone_number, start_date, bio, picture, member_count, link, name, is_private, group_id) VALUES
  (301, FALSE, 9891000001, 9891000002, '2025-01-01', 'Channel bio 1', 'chan1.jpg', 150, 'chanlink1', 'Channel1', TRUE, 1),
  (302, TRUE, 9891000002, 9891000003, '2025-01-05', 'Channel bio 2', 'chan2.jpg', 250, 'chanlink2', 'Channel2', FALSE, 2),
  (303, FALSE, 9891000003, 09120000008, '2025-01-10', 'Channel bio 3', 'chan3.jpg', 350, 'chanlink3', 'Channel3', TRUE, 3),
  (304, TRUE, 09120000008, 9891000005, '2025-01-15', 'Channel bio 4', 'chan4.jpg', 450, 'chanlink4', 'Channel4', FALSE, 4),
  (305, FALSE, 9891000005, 9891000001, '2025-01-20', 'Channel bio 5', 'chan5.jpg', 550, 'chanlink5', 'Channel5', TRUE, 5);

-- داده‌های جدول Member
INSERT INTO Member (phone_number, public_photo, bio, first_name, last_name, story1, story2, story3, user_name, last_seen, date_of_birth, user_id, chat_id) VALUES
  (9891000001, 'mphoto1.jpg', 'mbio1', 'Mohammad', 'Ahmadi', 'm1', 'm2', 'm3', 'mohammad', NOW(), '1990-01-01', 101, 301),
  (9891000009, 'mphoto1.jpg', 'mbio1', 'Mohammad', 'Ahmadi', 'm1', 'm2', 'm3', 'mohammad', NOW(), '1990-01-01', 101, 302),
  (9891000002, 'mphoto2.jpg', 'mbio2', 'Ali', 'Rezayi', 'm1', 'm2', 'm3', 'ali', NOW(), '1992-02-02', 102, 301),
  (9891000008, 'mphoto2.jpg', 'mbio2', 'Ali', 'Rezayi', 'm1', 'm2', 'm3', 'ali', NOW(), '1992-02-02', 102, 502),
  (9891000004, 'mphoto3.jpg', 'mbio3', 'Hossein', 'Karimi', 'm1', 'm2', 'm3', 'hossein', NOW(), '1991-03-03', 103, 502),
  (9891000003, 'mphoto3.jpg', 'mbio3', 'Hossein', 'Karimi', 'm1', 'm2', 'm3', 'hossein', NOW(), '1991-03-03', 103, 302),
  (09120000008, 'mphoto4.jpg', 'mbio4', 'Sara', 'Mohseni', 'm1', 'm2', 'm3', 'sara', NOW(), '1993-04-04', 104, 302),
  (9891000006, 'mphoto4.jpg', 'mbio4', 'Sara', 'Mohseni', 'm1', 'm2', 'm3', 'sara', NOW(), '1993-04-04', 104, 503),
  (9891000007, 'mphoto4.jpg', 'mbio4', 'Sara', 'Mohseni', 'm1', 'm2', 'm3', 'sara', NOW(), '1993-04-04', 104, 502),
  (9891000005, 'mphoto5.jpg', 'mbio5', 'Reza', 'Nazari', 'm1', 'm2', 'm3', 'reza', NOW(), '1994-05-05', 105, 303);

-- داده‌های جدول Admin
INSERT INTO Admins (phone_number, public_photo, bio, first_name, last_name, story1, story2, story3, user_name, last_seen, date_of_birth, user_id, chat_id) VALUES
  (9891000001, 'aphoto1.jpg', 'abio1', 'Mohammad', 'Ahmadi', 'a1', 'a2', 'a3', 'mohammad', NOW(), '1990-01-01', 101, 301),
  (9891000002, 'aphoto2.jpg', 'abio2', 'Ali', 'Rezayi', 'a1', 'a2', 'a3', 'ali', NOW(), '1992-02-02', 102, 301),
  (9891000003, 'aphoto3.jpg', 'abio3', 'Hossein', 'Karimi', 'a1', 'a2', 'a3', 'hossein', NOW(), '1991-03-03', 103, 302),
  (09120000008, 'aphoto4.jpg', 'abio4', 'Sara', 'Mohseni', 'a1', 'a2', 'a3', 'sara', NOW(), '1993-04-04', 104, 302),
  (9891000005, 'aphoto5.jpg', 'abio5', 'Reza', 'Nazari', 'a1', 'a2', 'a3', 'reza', NOW(), '1994-05-05', 105, 303);

-- داده‌های جدول personal
INSERT INTO personal (phone_number, chat_id, public_photo, bio, first_name, last_name, story1, story2, story3, user_name, last_seen, date_of_birth, is_archive, make_phone_number, de_phone_number, user_id) VALUES
  (9891000001, 401, 'pphoto1.jpg', 'pbio1', 'Mohammad', 'Ahmadi', 'p1', 'p2', 'p3', 'mohammad', NOW(), '1990-01-01', FALSE, 9891000001, 9891000002, 101),
  (9891000002, 402, 'pphoto2.jpg', 'pbio2', 'Ali', 'Rezayi', 'p1', 'p2', 'p3', 'ali', NOW(), '1992-02-02', TRUE, 9891000002, 9891000003, 102),
  (9891000003, 403, 'pphoto3.jpg', 'pbio3', 'Hossein', 'Karimi', 'p1', 'p2', 'p3', 'hossein', NOW(), '1991-03-03', FALSE, 9891000003, 09120000008, 103),
  (09120000008, 404, 'pphoto4.jpg', 'pbio4', 'Sara', 'Mohseni', 'p1', 'p2', 'p3', 'sara', NOW(), '1993-04-04', TRUE, 09120000008, 9891000005, 104),
  (9891000005, 405, 'pphoto5.jpg', 'pbio5', 'Reza', 'Nazari', 'p1', 'p2', 'p3', 'reza', NOW(), '1994-05-05', FALSE, 9891000005, 9891000001, 105);

-- داده‌های جدول Owner
INSERT INTO Owners (phone_number, public_photo, bio, first_name, last_name, story1, story2, story3, user_name, last_seen, date_of_birth, user_id, chat_id) VALUES
  (9891000001, 'ophoto1.jpg', 'obio1', 'Mohammad', 'Ahmadi', 'o1', 'o2', 'o3', 'mohammad', NOW(), '1990-01-01', 101, 301),
  (9891000002, 'ophoto2.jpg', 'obio2', 'Ali', 'Rezayi', 'o1', 'o2', 'o3', 'ali', NOW(), '1992-02-02', 102, 301),
  (9891000003, 'ophoto3.jpg', 'obio3', 'Hossein', 'Karimi', 'o1', 'o2', 'o3', 'hossein', NOW(), '1991-03-03', 103, 302),
  (09120000008, 'ophoto4.jpg', 'obio4', 'Sara', 'Mohseni', 'o1', 'o2', 'o3', 'sara', NOW(), '1993-04-04', 104, 302),
  (9891000005, 'ophoto5.jpg', 'obio5', 'Reza', 'Nazari', 'o1', 'o2', 'o3', 'reza', NOW(), '1994-05-05', 105, 303);

-- داده‌های جدول Group
INSERT INTO Groupss (chat_id, is_archive, make_phone_number, de_phone_number, start_date, bio, picture, member_count, link, name, is_private, is_super_group) VALUES
  (501, FALSE, 9891000001, 9891000002, '2025-01-01', 'Group bio 1', 'group1.jpg', 15000, 'glink1', 'Group1', TRUE, FALSE),
  (502, TRUE, 9891000002, 9891000003, '2025-01-05', 'Group bio 2', 'group2.jpg', 8000, 'glink2', 'Group2', FALSE, TRUE),
  (503, FALSE, 9891000003, 09120000008, '2025-01-10', 'Group bio 3', 'group3.jpg', 12000, 'glink3', 'Group3', TRUE, FALSE),
  (504, TRUE, 09120000008, 9891000005, '2025-01-15', 'Group bio 4', 'group4.jpg', 5000, 'glink4', 'Group4', FALSE, TRUE),
  (505, FALSE, 9891000005, 9891000001, '2025-01-20', 'Group bio 5', 'group5.jpg', 20000, 'glink5', 'Group5', TRUE, TRUE);

-- داده‌های جدول Text_message
INSERT INTO text_message (message_id, emoji, content, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address, reply_message_id, se_and_re_chat_id, de_chat_id, forward_chat_id, edit_chat_id, format_id) VALUES
  (1001, ':)', 'Hello Group1', 10, FALSE, 50, 'http://link1', FALSE, NOW()::TIMESTAMP, 101, 1001, NULL, 501, NULL, NULL, NULL, 1),
  (1002, ':D', 'Hi everyone', 12, FALSE, 60, 'http://link2', FALSE, (NOW() - INTERVAL '5 days')::TIMESTAMP, 102, 1002, NULL, 503, NULL, NULL, NULL, 1),
  (1003, ':(', 'Sad message', 8, TRUE, 40, 'http://link3', TRUE, (NOW() - INTERVAL '8 days')::TIMESTAMP, 103, 1003, NULL, 501, NULL, NULL, NULL, 2),
  (1004, ';)', 'Wink!', 15, FALSE, 55, 'http://link4', FALSE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 104, 1004, NULL, 503, NULL, NULL, NULL, 2),
  (1005, 'XD', 'Funny text', 9, TRUE, 45, 'http://link5', TRUE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 105, 1005, NULL, 501, NULL, NULL, NULL, 1),
  (1006, 'XD', 'Funny text', 9, TRUE, 45, 'http://link5', TRUE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 105, 1005, NULL, 502, NULL, NULL, NULL, 1),
  (1007, 'XD', 'Funny text', 9, TRUE, 45, 'http://link5', TRUE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 105, 1005, NULL, 505, NULL, NULL, NULL, 1),
  (1008, 'XD', 'Funny text', 9, TRUE, 45, 'http://link5', TRUE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 105, 1005, NULL, 201, NULL, NULL, NULL, 1),
  (1009, 'XD', 'Hello world', 9, TRUE, 45, 'http://link5', TRUE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 105, 1005, NULL, 201, NULL, NULL, NULL, 1),
  (1010, ':D', 'Hi everyone', 12, FALSE, 60, 'http://link2', FALSE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 102, 1002, NULL, 502, NULL, NULL, NULL, 1),
  (1011, 'XD', 'Good', 9, TRUE, 45, 'http://link5', TRUE, (NOW() - INTERVAL '11 days')::TIMESTAMP, 105, 1005, NULL, 205, NULL, NULL, NULL, 1);

-- داده‌های جدول Sticker
INSERT INTO Sticker (message_id, codes, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address, reply_message_id, se_and_re_chat_id, de_chat_id, forward_chat_id, edit_chat_id, make_user_id, pack_id) VALUES
  (2001,1 , 5, FALSE, 30, 'http://sticker1', FALSE, NOW(), 101, 1001, NULL, 501, NULL, NULL, NULL, 101, 1),
  (2002,2 , 6, TRUE, 35, 'http://sticker2', TRUE, (NOW() - INTERVAL '1 days')::TIMESTAMP, 101, 1002, NULL, 501, NULL, NULL, NULL, 101, 1),
  (2003,3 , 7, FALSE, 25, 'http://sticker3', FALSE, (NOW() - INTERVAL '2 days')::TIMESTAMP, 101, 1003, NULL, 501, NULL, NULL, NULL, 101, 2),
  (2006,2 , 6, TRUE, 35, 'http://sticker2', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 101, 1002, NULL, 501, NULL, NULL, NULL, 101, 1),
  (2007,3 , 7, FALSE, 25, 'http://sticker3', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 101, 1003, NULL, 501, NULL, NULL, NULL, 101, 2),
  (2008,2 , 6, TRUE, 35, 'http://sticker2', TRUE, (NOW() - INTERVAL '5 days')::TIMESTAMP, 101, 1002, NULL, 501, NULL, NULL, NULL, 101, 1),
  (2009,6 , 7, FALSE, 25, 'http://sticker3', FALSE, (NOW() - INTERVAL '6 days')::TIMESTAMP, 101, 1003, NULL, 501, NULL, NULL, NULL, 101, 2),
  (2004,4 , 5, TRUE, 28, 'http://sticker4', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 102, 1004, NULL, 503, NULL, NULL, NULL, 102, 2),
  (2005,5 , 6, FALSE, 32, 'http://sticker5', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 103, 1005, NULL, 503, NULL, NULL, NULL, 103, 2);

-- داده‌های جدول poll
INSERT INTO poll (message_id, name, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (3001, 'Favorite Color?', 30, FALSE, 50, 'http://poll1', FALSE, NOW()::TIMESTAMP, 101, 1001),
    (3002, 'Best Movie?', 45, FALSE, 60, 'http://poll2', FALSE, NOW()::TIMESTAMP, 102, 1002),
    (3003, 'Next Holiday Destination?', 20, TRUE, 40, 'http://poll3', TRUE, NOW()::TIMESTAMP, 103, 1003),
    (3004, 'Best Sport?', 25, FALSE, 55, 'http://poll4', FALSE, NOW()::TIMESTAMP, 104, 1004),
    (3005, 'Favorite Food?', 35, TRUE, 45, 'http://poll5', TRUE, NOW()::TIMESTAMP, 105, 1005);

-- داده‌های جدول Location
INSERT INTO Locations (message_id, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (4001, 10, FALSE, 50, 'http://loc1', FALSE, NOW()::TIMESTAMP, 101, 1001),
    (4002, 15, FALSE, 60, 'http://loc2', FALSE, NOW()::TIMESTAMP, 102, 1002),
    (4003, 12, TRUE, 40, 'http://loc3', TRUE, NOW()::TIMESTAMP, 103, 1003),
    (4004, 20, FALSE, 55, 'http://loc4', FALSE, NOW()::TIMESTAMP, 104, 1004),
    (4005, 18, TRUE, 45, 'http://loc5', TRUE, NOW()::TIMESTAMP, 105, 1005);

-- داده‌های جدول File
INSERT INTO File (message_id, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (5001, 5, FALSE, 150, 'http://file1', FALSE, NOW()::TIMESTAMP, 101, 1001),
    (5002, 6, TRUE, 300, 'http://file2', TRUE, NOW()::TIMESTAMP, 102, 1002),
    (5003, 7, FALSE, 250, 'http://file3', FALSE, NOW()::TIMESTAMP, 103, 1003),
    (5004, 8, TRUE, 400, 'http://file4', TRUE, NOW()::TIMESTAMP, 104, 1004),
    (5005, 9, FALSE, 100, 'http://file5', FALSE, NOW()::TIMESTAMP, 105, 1005);

-- داده‌های جدول Video
INSERT INTO Video (message_id, duration, quality, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (6001, 120, 1080, 15, FALSE, 500, 'http://video1.mp4', FALSE, NOW()::TIMESTAMP, 101, 1001),
    (6002, 90, 720, 10, TRUE, 350, 'http://video2.mp4', TRUE, (NOW() - INTERVAL '1 days')::TIMESTAMP, 102, 1002),
    (6003, 180, 4096, 20, FALSE, 800, 'http://video3.mp4', FALSE, (NOW() - INTERVAL '2 days')::TIMESTAMP, 103, 1003),
    (6004, 60, 480, 5, TRUE, 250, 'http://video4.mp4', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 104, 1004),
    (6005, 150, 1080, 12, FALSE, 600, 'http://video5.mp4', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 105, 1005);

-- داده‌های جدول Voice
INSERT INTO Voice (message_id, duration, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (7001, 30, 5, FALSE, 100, 'http://voice1.ogg', FALSE, NOW()::TIMESTAMP, 101, 1001),
    (7002, 45, 7, TRUE, 120, 'http://voice2.ogg', TRUE, (NOW() - INTERVAL '1 days')::TIMESTAMP, 102, 1002),
    (7003, 60, 8, FALSE, 150, 'http://voice3.ogg', FALSE, (NOW() - INTERVAL '2 days')::TIMESTAMP, 103, 1003),
    (7004, 20, 4, TRUE, 80, 'http://voice4.ogg', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 104, 1004),
    (7005, 50, 6, FALSE, 130, 'http://voice5.ogg', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 105, 1005);

-- داده‌های جدول Music
INSERT INTO Music (message_id, duration, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (8001, 180, 10, FALSE, 400, 'http://music1.mp3', FALSE, NOW(), 101, 1001),
    (8002, 240, 12, TRUE, 500, 'http://music2.mp3', TRUE, (NOW() - INTERVAL '1 days')::TIMESTAMP, 102, 1002),
    (8003, 300, 15, FALSE, 600, 'http://music3.mp3', FALSE, (NOW() - INTERVAL '2 days')::TIMESTAMP, 103, 1003),
    (8004, 90, 8, TRUE, 250, 'http://music4.mp3', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 104, 1004),
    (8005, 210, 11, FALSE, 450, 'http://music5.mp3', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 105, 1005);

-- داده‌های جدول Gif
INSERT INTO Gif (message_id, codes, duration, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (9001, 1, 5, 3, FALSE, 200, 'http://gif1.gif', FALSE, NOW(), 101, 1001),
    (9002, 2, 7, 4, TRUE, 250, 'http://gif2.gif', TRUE, (NOW() - INTERVAL '1 days')::TIMESTAMP, 102, 1002),
    (9003, 3, 10, 5, FALSE, 300, 'http://gif3.gif', FALSE, (NOW() - INTERVAL '2 days')::TIMESTAMP, 103, 1003),
    (9004, 4, 6, 3, TRUE, 220, 'http://gif4.gif', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 104, 1004),
    (9005, 5, 8, 4, FALSE, 270, 'http://gif5.gif', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 105, 1005);

-- داده‌های جدول Picture
INSERT INTO Picture (message_id, quality, timed, is_once_seen, size, link, is_pinned, msg_date, user_id, address)
VALUES 
    (10001, 1080, 5, FALSE, 300, 'http://pic1.jpg', FALSE, NOW(), 101, 1001),
    (10002, 720, 7, TRUE, 250, 'http://pic2.jpg', TRUE, (NOW() - INTERVAL '1 days')::TIMESTAMP, 102, 1002),
    (10003, 4096, 10, FALSE, 500, 'http://pic3.jpg', FALSE, (NOW() - INTERVAL '2 days')::TIMESTAMP, 103, 1003),
    (10004, 480, 6, TRUE, 220, 'http://pic4.jpg', TRUE, (NOW() - INTERVAL '3 days')::TIMESTAMP, 104, 1004),
    (10005, 1080, 8, FALSE, 350, 'http://pic5.jpg', FALSE, (NOW() - INTERVAL '4 days')::TIMESTAMP, 105, 1005);


--------------------------------------------------
-- بخش کوئری‌ها
--------------------------------------------------

-- 1. سه استیکر پر استفاده کاربر با شناسه 'mohammad' (براساس تعداد تکرار در جدول Sticker)
SELECT s.codes,
       COUNT(s.codes) AS usage_count
FROM Sticker s
WHERE s.user_id = (
    SELECT u.user_id
    FROM Users u
    JOIN contact c ON u.user_id = c.user_id
    WHERE c.user_name = 'mohammad'
    LIMIT 1
)
GROUP BY s.codes
ORDER BY usage_count DESC
LIMIT 3;

-- 2. تمام مخاطبان مشترک بین کاربر با شناسه 'ali' و 'mohammad'
WITH Mohammad AS (
    SELECT c.user_id 
    FROM contact c
    WHERE c.user_name = 'mohammad'
), 
Ali AS (
    SELECT c1.user_id 
    FROM contact c1 
    WHERE c1.user_name = 'ali'
)
SELECT c.phone_number, c.first_name, c.last_name 
FROM contact c
JOIN Mohammad m ON c.user_id = m.user_id
UNION
SELECT c.phone_number, c.first_name, c.last_name 
FROM contact c
JOIN Ali a ON c.user_id = a.user_id;

-- 3. تعداد پیام‌ها به همراه نام گروه‌های با تعداد کاربر بیش از ۱۰ هزار نفر (براساس پیام‌های متنی)
SELECT g.name,
       COUNT(t.message_id) AS message_count
FROM Groupss g
JOIN text_message t ON t.se_and_re_chat_id = g.chat_id
WHERE g.member_count > 10000
GROUP BY g.name
ORDER BY message_count;

-- 4. نام گروه با بیشترین تعداد پیام در ۱۰ روز اخیر
SELECT g.name
FROM Groupss g
JOIN text_message t ON t.se_and_re_chat_id = g.chat_id
WHERE t.msg_date >= NOW() - INTERVAL '10 days'
GROUP BY g.name
ORDER BY COUNT(t.message_id) DESC
LIMIT 1;

-- 5. مجموع حجم فایل‌های آپلود شده توسط کاربر با بیشترین عضویت در گروه‌ها
-- فرض: در اینجا پیام‌های فایل در جدول File فرض می‌شود؛ از آنجا که جدول File تعریف نشده، از جدول Text_message به عنوان نمونه استفاده می‌کنیم.
WITH user_membership AS (
  SELECT user_id, COUNT(*) AS groups_count
  FROM Member
  GROUP BY user_id
  ORDER BY groups_count DESC
  LIMIT 1
)
SELECT SUM(f.size) AS total_file_size
FROM File f
WHERE f.user_id = (SELECT user_id FROM user_membership);

-- 6. نام کاربرانی که حداکثر در دو گروه عضو هستند
SELECT c.user_name
FROM contact c
JOIN Users u ON c.user_id = u.user_id
JOIN Member m ON m.user_id = u.user_id
JOIN Groupss g ON g.chat_id = m.chat_id
GROUP BY c.user_name
HAVING COUNT(m.chat_id) <= 2;

-- 7. شماره تماس افرادی که با '0912' شروع و به '8' ختم می‌شوند
SELECT COALESCE(phone_number, 0) AS phone
FROM contact
WHERE ROUND(phone_number/10000000) = 0912 AND (phone_number%10) =8;

-- 8. کاربرانی که دقیقا دارای ۲ کانال هستند (فرض شده اطلاعات کانال‌ها در جدول personal ثبت شده‌اند)
SELECT o.user_name
FROM Owners o
JOIN Users u ON o.user_id = u.user_id
JOIN Member m ON m.user_id = u.user_id
JOIN channel c ON c.chat_id = m.chat_id
GROUP BY o.user_name
HAVING COUNT(m.chat_id) = 2;

SELECT c.user_name
FROM contact c
JOIN Users u ON c.user_id = u.user_id
JOIN Member m ON m.user_id = u.user_id
JOIN channel c1 ON c1.chat_id = m.chat_id
GROUP BY c.user_name
HAVING COUNT(m.chat_id) = 2;

-- 9. تمام پیام‌هایی که در گروه‌های مشترک کاربر با شناسه 'hossein' و 'ali' وجود دارد
-- یافتن شناسه‌های کاربری hossein و ali
WITH user_ids AS (
    SELECT u.user_id
    FROM Users u
    JOIN contact c ON u.user_id = c.user_id
    WHERE c.user_name IN ('hossein', 'ali')
),

-- یافتن گروه‌های مشترک بین hossein و ali
common_groups AS (
    SELECT m.chat_id
    FROM Member m
    JOIN user_ids u ON m.user_id = u.user_id
    GROUP BY m.chat_id
    HAVING COUNT(DISTINCT m.user_id) = 2
)

-- یافتن پیام‌های ارسال شده در گروه‌های مشترک
SELECT t.message_id, t.content, t.msg_date, t.user_id, t.se_and_re_chat_id AS group_id
FROM text_message t
JOIN common_groups cg ON t.se_and_re_chat_id = cg.chat_id
ORDER BY t.msg_date;

-- 10. میانه تعداد کاراکتر پیام‌های ارسال شده به ربات با شناسه 'first_bot'
SELECT AVG(LENGTH(t.content)) AS average_characters
FROM text_message t
JOIN Bot b ON t.se_and_re_chat_id = b.chat_id
WHERE b.name = 'first_bot';
