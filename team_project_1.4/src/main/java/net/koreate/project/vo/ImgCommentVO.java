package net.koreate.project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ImgCommentVO {
	private int cno; // 코멘트 번호
	private int bno; // 원본 게시글 번호
	private String commentText; // 코멘트 내용
	private String commentAuth; // 코멘트 작성자
	private Date regdate; // 코멘트 작성일
	private Date updatedate; // 코멘트 수정일
	private int uno; // 회원번호
}
