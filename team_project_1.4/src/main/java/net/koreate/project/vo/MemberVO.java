package net.koreate.project.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private int u_no; // 회원번호 
	private String u_id; // 아이디
	private String u_pw; // 비밀번호
	private String u_phone; // 전화번호
	private String u_birth; // 생년월일
	private String u_name; // 이름
	private String u_addr; // 주소
	private String u_addr_detail; // 상세 주소
	private String u_addr_post; // 우편 번호
	private int u_point; // 유저 포인트
	private String u_info; // 개인 정보 동의
	private Date u_date; // 가입일
	private Date u_visit_date; // 마지막 방문일
	private String u_withdraw; // 탈퇴일
	private String u_category; //일반, 네이버 가입
	private String u_pwChange; //
	
	private List<AuthVO> authList;
}
