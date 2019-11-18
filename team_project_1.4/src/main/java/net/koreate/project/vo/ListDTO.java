package net.koreate.project.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ListDTO {
	private String boardName;
	private String title;
	private int viewcnt;
	private int bno;
	private Date updatedate;
	private String showboard;
}
