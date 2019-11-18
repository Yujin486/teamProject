package net.koreate.project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int bno; // 번호
	private String title; // 제목
	private String content; // 내용
	private String writer; // 작성자
	private String password;
	private int origin; // 원글번호
	private int depth; // 답글표현
	private int seq; // 답글정렬순서
	private Date regdate; // 등록일
	private Date updatedate; // 수정일
	private int viewcnt; // 조회수
	private String showboard; // 삭제유무
	private String boardName;
	
	private int u_no; // 작성자
	
	private String[] files; // 첨부파일경로와 이름 목록
	private int commentCnt;  // 전체댓글의개수

}
