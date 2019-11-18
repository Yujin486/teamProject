-- 사용자 정보
CREATE TABLE user_member(
	u_no INT PRIMARY KEY auto_increment,			-- 회원번호
	u_id VARCHAR(50) NOT NULL UNIQUE,				-- 회원아이디(email)
	u_pw VARCHAR(200) NOT NULL,						-- 비밀번호
	u_phone VARCHAR(20) NOT NULL,					-- 전화번호
	u_birth VARCHAR(20) NOT NULL,					-- 생년월일
	u_name VARCHAR(20) NOT NULL,					-- 이름
	u_addr VARCHAR(100),							-- 주소
	u_addr_detail VARCHAR(200),						-- 상세주소
	u_addr_post VARCHAR(20),						-- 우편번호
	u_point INT DEFAULT 0,							-- 포인트
	u_info CHAR(1) DEFAULT 'y',						-- 개인정보 이용 동의
	u_date TIMESTAMP NOT NULL DEFAULT now(),		-- 계정 생성일
	u_visit_date TIMESTAMP NOT NULL DEFAULT now(),	-- 최종 방문일(마지막 로그인)
	u_withdraw CHAR(1) DEFAULT 'n'					-- 회원정보숨김(탈퇴)
);
insert into user_member(u_id, u_pw,u_phone,u_birth, u_name) values('asdf123@naver.com', 'asdf123', '010-1234-5678', '20010321', '관리자');
insert into user_member(u_id, u_pw,u_phone,u_birth, u_name) values('id001@naver.com', 'id001', '010-1234-5678', '20010321', '루라라');
select * from user_member;
delete from user_member;
delete from user_member where u_id = 'elin35@naver.com';
ALTER TABLE user_member ADD u_category VARCHAR(20) DEFAULT 'normal';
ALTER TABLE user_member ADD u_pwChange CHAR(1) DEFAULT '1';
ALTER TABLE user_member drop u_pwChange;

ALTER TABLE user_member drop u_category;

--사용자 권한
CREATE TABLE user_member_auth(
	u_id varchar(50) NOT NULL,
	auth varchar(50) NOT NULL
);
ALTER TABLE user_member_auth ADD CONSTRAINT fk_user_member FOREIGN KEY(u_id) REFERENCES user_member(u_id);

insert into user_member_auth values('id1234@naver.com', 'ROLE_MASTER');
insert into user_member_auth values('id001@naver.com', 'ROLE_MASTER');
select * from user_member_auth;

select re_board.*, re_attach.* from re_board, re_attach where re_board.bno=121;
delete from user_member_auth where u_id = 'elin35@naver.com';
SELECT count(*) FROM user_member;

-- 공지 답변형 게시판
CREATE TABLE re_board(
	bno INT PRIMARY KEY auto_increment,
	title VARCHAR(200) NOT NULL,
	content TEXT NOT NULL,
	writer VARCHAR(45) NOT NULL,
	origin INT NULL DEFAULT 0,
	depth INT NULL DEFAULT 0,
	seq INT NULL DEFAULT 0,
	regdate TIMESTAMP NULL DEFAULT now(),
	updatedate TIMESTAMP NULL DEFAULT now(),
	viewcnt INT NULL DEFAULT 0,
	showboard VARCHAR(10) NULL DEFAULT 'y',
	u_no INT NOT NULL
); 

ALTER TABLE re_board ADD CONSTRAINT fk_re_board FOREIGN KEY(u_no) REFERENCES user_member(u_no);
alter table re_board add boardName varchar(20) default 'notice';

select * from re_board;
delete from re_board;
drop table re_board;

SELECT * FROM re_board ORDER BY bno DESC limit 0, 10 ;
INSERT INTO re_board(title, content, writer, uno, origin) SELECT title, content, writer, uno FROM re_board;
SELECT * FROM re_board ORDER BY origin DESC, seq ASC limit 0, 10;

-- 첨부파일
CREATE TABLE re_attach(
	fullname VARCHAR(200) NOT NULL,
	bno INT NOT NULL,
	regdate TIMESTAMP NULL DEFAULT now(),
	constraint fk_re_attach FOREIGN KEY(bno) REFERENCES re_board(bno)
);
select * from re_attach;
drop table re_attach;
DROP TABLE img_board;
DROP TABLE img_attach;
DROP TABLE img_comment;

-- 질문 게시판
CREATE TABLE qna_board(
	bno INT PRIMARY KEY auto_increment,
	title VARCHAR(200) NOT NULL,
	content TEXT NOT NULL,
	writer VARCHAR(45) NOT NULL,
	password VARCHAR(200) NOT NULL,
	origin INT NULL DEFAULT 0,
	depth INT NULL DEFAULT 0,
	seq INT NULL DEFAULT 0,
	regdate TIMESTAMP NULL DEFAULT now(),
	updatedate TIMESTAMP NULL DEFAULT now(),
	viewcnt INT NULL DEFAULT 0,
	showboard VARCHAR(10) NULL DEFAULT 'y',
	u_no INT NOT NULL,
	boardName varchar(20) default 'QnA',
	constraint fk_qna_board FOREIGN KEY(u_no) REFERENCES user_member(u_no)
);
select * from qna_board;
drop table qna_board;


-- 질문 첨부파일
CREATE TABLE qna_attach(
	fullname VARCHAR(200) NOT NULL,
	bno INT NOT NULL,
	regdate TIMESTAMP NULL DEFAULT now(),
	constraint fk_qna_attach FOREIGN KEY(bno) REFERENCES qna_board(bno)
);
select * from qna_attach;
drop table qna_attach;

-- 이미지 답변형 게시판
CREATE TABLE img_board(
	bno INT PRIMARY KEY auto_increment,
	title VARCHAR(200) NOT NULL,
	content TEXT NOT NULL,
	writer VARCHAR(45) NOT NULL,
	origin INT NULL DEFAULT 0,
	regdate TIMESTAMP NULL DEFAULT now(),
	updatedate TIMESTAMP NULL DEFAULT now(),
	viewcnt INT NULL DEFAULT 0,
	uno INT NOT NULL,
	locForm VARCHAR(300) NOT NULL,
	profileFile VARCHAR(200),
	constraint fk_img_board_uno FOREIGN KEY(uno) REFERENCES user_member(u_no)	
); 
select * from img_board;
alter table img_board add boardName varchar(20) default 'main';
alter table img_board drop boardName;
alter table img_board add showboard VARCHAR(10) NULL DEFAULT 'y';

-- 이미지 게시판 댓글
CREATE TABLE img_comment(
	cno INT PRIMARY KEY auto_increment,
	bno INT NOT NULL default 0,
	commentText TEXT NOT NULL,
	commentAuth VARCHAR(50) NOT NULL,
	regdate TIMESTAMP NOT NULL DEFAULT now(),
	updatedate TIMESTAMP NOT NULL DEFAULT now(),
	uno int not null default 1,
	constraint fk_img_comment_bno FOREIGN KEY(bno) REFERENCES img_board(bno)
);
-- 이거 안 쓰는 거.
constraint fk_img_comment_uno FOREIGN KEY(uno) REFERENCES user_member(u_no)	

-- 이미지 게시판 첨부파일
CREATE TABLE img_attach(
	fullname VARCHAR(200) NOT NULL,
	bno INT NOT NULL,
	regdate TIMESTAMP NULL DEFAULT now(),
	constraint fk_img_attach FOREIGN KEY(bno) REFERENCES img_board(bno)
);


