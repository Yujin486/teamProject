package net.koreate.project.vo;

import lombok.Data;

@Data
public class LoginDTO {
	private String uid; // 아이디
	private String upw; // 비밀번호
	private boolean userCookie;  // 로그인 유지 쿠키 
}
