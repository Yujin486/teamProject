package net.koreate.project.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.project.security.CustomUser;
import net.koreate.project.service.UserService;
import net.koreate.project.vo.MemberVO;

@Controller 
@RequestMapping("/user/*")
public class UserController {
	
	@Inject
	UserService us;
	
	@GetMapping("/join")
	public  String join() {
		return "user/join";
	}
	
	@PostMapping("/joinPost")
	public String joinPost(MemberVO vo, RedirectAttributes rttr) throws Exception {
		System.out.println("joinPost MemberVO" + vo);
		System.out.println(vo.getU_pw());
		us.join(vo);
		rttr.addFlashAttribute("message", "회원가입에 성공하셨습니다.");
		return "redirect:/user/login";
	}
	
	@GetMapping("/login")
	public String login(String error, String logout, Model model) {
		if (error != null)
			model.addAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다");
		return "user/login";
	}		
	
	@GetMapping("/callback")
	public String callback() {
		return "user/callback";
	}
	
	//   uIdCheck
	@PostMapping("/uIdCheck")
	@ResponseBody
	public boolean uIdCheck(String u_id) throws Exception{
		return us.getMemberById(u_id);
	}
	
	@PostMapping("/naverIdCheck")
	@ResponseBody
	public boolean naveruIdCheck(String sns_id, String sns_name, String sns_birth) throws Exception{
		System.out.println("컨트롤러 도착^^");
		
		Map<String, String> naverLogin = new HashMap<>();
		naverLogin.put("sns_id", sns_id);
		naverLogin.put("sns_name", sns_name);
		naverLogin.put("sns_birth", sns_birth);
		naverLogin.put("sns_category", "naver");
		naverLogin.put("sns_pwChange", "0");
		
		if(us.getMemberById(sns_id) == true) {
			System.out.println("회원가입 시작");
			us.naverJoin(naverLogin);
		}else {
			System.out.println(sns_id+"는 가입된 회원이얌");
		}
		return true;
	}
	
	@RequestMapping(value="/uPwCheck" , method = {RequestMethod.GET, RequestMethod.POST}) 
	@ResponseBody
	public boolean uPwCheck(String now_u_pw) throws Exception {
		System.out.println("비밀번호 변경 예정");
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("비밀번호 변경 전 비밀번호 체크  : " +user.getMember().getU_pw());
		return us.checkPw(now_u_pw, user.getMember().getU_pw());
	}
	
	@GetMapping("/logout")
	public String logOut() {
		System.out.println("get CUSTOM logout");
		return "/user/logout";
	}
	
	@GetMapping("/myPage")
	public String myPage() {
		return "user/myPage";
	}
	
	@GetMapping("/profileModify")
	public String profileModify() {
		return "user/myPageModify";
	}

	@PostMapping("/profileModify")
	public String profileModify(MemberVO vo, RedirectAttributes rttr) throws Exception {
		us.profileModify(vo);
		rttr.addFlashAttribute("message", "회원정보가 변경되었습니다.");
		return "redirect:/user/myPage";
	}
	
	@GetMapping("/passwordModifyPage")
	public String passwordModifyPage() throws Exception {
		return "user/passwordModify";
	}
	
	@PostMapping("/passwordModify")
	public String passwordModify(MemberVO vo, RedirectAttributes rttr) throws Exception {
		us.passwordModify(vo);
		rttr.addFlashAttribute("message", "비밀번호가 변경되었습니다.");
		return "redirect:/user/myPage";
	}

	@GetMapping("/profileDelete")
	public String deleteYN(MemberVO vo, RedirectAttributes rttr) {
		us.deleteYN(vo);
		rttr.addFlashAttribute("message", "탈퇴가 완료되었습니다.");
		return "redirect:/user/logout";
	}

}
