package net.koreate.project.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import net.koreate.project.service.UserService;
import net.koreate.project.vo.MemberVO;

//로그인성공시 실행
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Inject
	UserService us;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		System.out.println("Login Success");
		
		List<String> roleNames = new ArrayList<>();
		
		for(GrantedAuthority authentication : auth.getAuthorities()) {
			System.out.println("authority :" +authentication.getAuthority());
			roleNames.add(authentication.getAuthority());
		}
		System.out.println("roleNames :" +roleNames);
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		MemberVO vo = user.getMember();
		
		if (vo.getU_withdraw().equals("y")) {
			System.out.println(vo.getU_withdraw() + " : 탈퇴회원");
			response.sendRedirect("/user/logout");
		} else if(vo.getU_pwChange().equals("0")){
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('네이버 로그인 시 최초 비밀번호 변경이 필요합니다.');window.location='/user/passwordModifyPage';</script>");
		}else {
			System.out.println("User 정보 : " + auth.getPrincipal());
			System.out.println("Login Member : " + vo);
			us.updateVisitDate(vo.getU_id());
			response.sendRedirect("/imgboard/imgBoardList");
		}

	}

}
