package net.koreate.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RegistDTO {
	
	private String title;
	private String content;
	private String writer;
	private String password;
	private int u_no;
	
	private MultipartFile[] files;

}
