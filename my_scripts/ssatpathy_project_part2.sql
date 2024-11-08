/* 
	Sangeet Satpathy
    Final Project Part 2
    CS31A
    3/20/23
*/

/* Creates database */
CREATE DATABASE SocialMeet;

/* Uses database */
USE SocialMeet;

/* Creates a table of zip codes. */
CREATE TABLE zip_codes (
	zip CHAR(5) PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    state VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL
);

/* Creates a table of users */
CREATE TABLE `user` (
	user_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    street_address VARCHAR(50) NOT NULL,
    zipcode CHAR(5) NOT NULL,
    phone CHAR(10),
    email VARCHAR(255) UNIQUE NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    user_status VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (zipcode) REFERENCES zip_codes (zip),
    CHECK(user_status IN ("Online", "Away", "Offline", "Do Not Disturb"))
);

/* Creates a table of friend requests. 
Indicates whether they are accepted, pending, or rejected. 
Serves as a list of friends. */
CREATE TABLE user_friend (
	request_id INT AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    action_time DATETIME NOT NULL,
    action_taken VARCHAR(10) NOT NULL,
    PRIMARY KEY(request_id),
    FOREIGN KEY (sender_id) REFERENCES `user`(user_id),
    FOREIGN KEY (receiver_id) REFERENCES `user`(user_id),
    CHECK(action_taken IN ("Accepted", "Declined", "Pending"))
);

/* Creates a table of messages, including a sender and a recipient. */
CREATE TABLE user_message (
	message_id INT AUTO_INCREMENT,
    from_user_id INT NOT NULL,
    to_user_id INT NOT NULL,
    `message_text` VARCHAR(225) NOT NULL,
    date_sent DATE NOT NULL,
    date_read DATE,
    PRIMARY KEY (message_id),
    FOREIGN KEY (from_user_id) REFERENCES `user`(user_id),
    FOREIGN KEY (to_user_id) REFERENCES `user`(user_id)
);

/* Creates a table of posts. */
CREATE TABLE user_post (
	post_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    post_content VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (post_id),
    FOREIGN KEY (user_id) REFERENCES `user` (user_id)
);

/* Creates a table of categories of groups for reference */
CREATE TABLE category (
	category_id INT AUTO_INCREMENT,
    category_name VARCHAR(30) UNIQUE NOT NULL,
    PRIMARY KEY (category_id),
    CHECK(category_name IN ("General", "Buy and Sell", 
    "Social Learning", "Community", "Dancing", "Jobs", "Lifestyle", "Movies & Film", "Music", 
    "Parents & Family", "Animals", "Gaming", "Religion", "Sports"))
);

/* Creates a table of comments for every post. 
Links foreign key to other post id's along with the user who wrote the comment.*/
CREATE TABLE post_comments (
	comment_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    user_comment VARCHAR(255) NOT NULL,
    created_date DATE NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (post_id) REFERENCES user_post (post_id)
);

/* Creates a table of groups along with their information.*/
CREATE TABLE group_info (
	group_id INT AUTO_INCREMENT,
    category_id INT NOT NULL,
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    join_mode VARCHAR(30) NOT NULL,
    group_name VARCHAR(50) UNIQUE NOT NULL,
    visibility VARCHAR(10) NOT NULL,
    created_on DATETIME UNIQUE NOT NULL,
    PRIMARY KEY (group_id),
    FOREIGN KEY (category_id) REFERENCES category (category_id),
    FOREIGN KEY (created_by) REFERENCES `user` (user_id),
    FOREIGN KEY (updated_by) REFERENCES `user` (user_id),
    CHECK(visibility IN ("Public", "Private")),
    CHECK(join_mode IN ("Open", "Closed", "Waiting for Approval"))
);


/* Creates a table of group memberships. 
This serves as an intermediary between the users & different groups with a many-many relationship.*/
CREATE TABLE group_member (
	membership_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    member_rank VARCHAR(30) NOT NULL,
    group_id INT NOT NULL,
    PRIMARY KEY (membership_id),
    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (group_id) REFERENCES group_info (group_id),
    CHECK (member_rank IN ("Pending", "Member", "Moderator", "Admin", "Owner")),
    UNIQUE (user_id, group_id)
);

/* Creates a table of group messages sent on each group. */
CREATE TABLE group_message (
	message_id INT AUTO_INCREMENT,
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    message VARCHAR(255),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY(message_id)
);

/* Query 1:
Display all the groups’ details alphabetically by group name.*/
SELECT *
FROM group_info
ORDER BY group_name;

/* Query 2:
Find the names of all the users who live in the city of San Francisco.*/
SELECT first_name,
	   last_name
FROM `user`
JOIN zip_codes
ON `user`.zipcode = zip_codes.zip
WHERE zip_codes.city_name = "San Francisco";

/* Query 3
List the names and addresses of all users, alphabetically ordered by last name.
*/
SELECT first_name,
	   last_name,
       street_address,
       zipcode,
       city_name,
       state,
       country
FROM `user`
JOIN zip_codes
ON `user`.zipcode = zip_codes.zip
ORDER BY last_name;

/* Query 4 
Which posts have the word “help” in their contents? List the post content only.*/
SELECT post_content
FROM user_post
WHERE post_content LIKE "%help%";

/* Query 5 
Display the email address and city of all users.*/
SELECT email,
	   city_name
FROM `user`
JOIN zip_codes
ON `user`.zipcode = zip_codes.zip;

/* Query 6 
Display the three users who have sent the most friend requests. Your query should return the user’s last name and number of requests sent.*/
SELECT COUNT(*),
	   last_name
FROM user_friend
JOIN `user`
ON user_friend.sender_id = `user`.user_id
GROUP BY sender_id
LIMIT 3;

/* Query 7 
Determine the number of accepted friend requests.*/
SELECT COUNT(*)
FROM user_friend
WHERE action_taken = "Accepted";

/* Query 8
Display the percentage of requests who were accepted. */
SELECT (COUNT(*) /
(SELECT COUNT(*) FROM user_friend)) * 100 AS percentAccepted
FROM user_friend
WHERE action_taken = "Accepted";

/* Query 9 
Determine the users with more than 10 unread messages and how many unread messages each have.*/
SELECT to_user_id,
	   COUNT(*) AS numUnreadMsgs
FROM user_message
WHERE date_read IS NULL
GROUP BY to_user_id
HAVING numUnreadMsgs > 10;

/* Query 10 
Display posts which don’t have any comments.*/
SELECT post_id
FROM user_post
WHERE post_id NOT IN
(SELECT DISTINCT post_id FROM post_comments);

/* Query 11 
Calculate how many groups are currently open, waiting for approval, and/or closed.*/
SELECT join_mode, 
	   COUNT(*)
FROM group_info
GROUP BY join_mode;

/* Query 12 
Display the five most popular group categories.*/
SELECT SUM(memberCountInGroup) AS memberCountInCategory
FROM
(SELECT COUNT(*) AS memberCountInGroup,
		category_id 
FROM group_member
JOIN group_info 
ON group_member.group_id = group_info.group_id
GROUP BY group_member.group_id) membersPerGroup
GROUP BY category_id
ORDER BY memberCountInCategory DESC
LIMIT 5;

/* Query 13
Display the five least popular group categories? */
SELECT SUM(memberCountInGroup) AS memberCountInCategory
FROM
(SELECT COUNT(*) AS memberCountInGroup,
		category_id 
FROM group_member
JOIN group_info 
ON group_member.group_id = group_info.group_id
GROUP BY group_member.group_id) membersPerGroup2
GROUP BY category_id
ORDER BY memberCountInCategory
LIMIT 5;

/* Query 14
Calculate how many members SocialMeet has. */
SELECT COUNT(DISTINCT user_id)
FROM group_member;

/* Query 15 
Calculate the longest running group on SocialMeet and how many members belong in that group.
*/
SELECT group_member.group_id,
	   COUNT(user_id) AS numMembers
FROM group_member
JOIN group_info
ON group_member.group_id = group_info.group_id
WHERE group_info.created_on = 
(SELECT MIN(created_on) FROM group_info)
GROUP BY group_id;