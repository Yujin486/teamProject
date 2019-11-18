package net.koreate.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.project.security.CustomUser;
import net.koreate.project.service.BoardService;
import net.koreate.project.service.ImgBoardService;
import net.koreate.project.service.MngtService;
import net.koreate.project.service.QnaService;
import net.koreate.project.service.UserService;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.AuthVO;
import net.koreate.project.vo.ListDTO;
import net.koreate.project.vo.MemberVO;

@Controller
@RequestMapping("/mngt/*")
public class mngtController {
	
	@Inject
	UserService us;
	
	@Inject
	MngtService ms;
	
	@Inject
	BoardService bs;
	
	@Inject
	ImgBoardService ibs;
	
	@Inject
	QnaService qs;
	
	@GetMapping("memberList")
	public String memberList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute("memberList", us.getMemberById(cri));
		model.addAttribute("pageMaker", us.getPageMaker(cri));
		return "mngt/memberList";
	}
	
	@PostMapping("user/delete")
	@ResponseBody
	public String MngtdeleteYN(MemberVO vo) throws Exception{
		System.out.println(vo);
		us.mngtDeleteYN(vo);
		return vo.getU_withdraw();
	}
	
	@PostMapping("user/changeAuth")
	@ResponseBody
	public List<AuthVO> changeAut(AuthVO auth) throws Exception{
		System.out.println(auth);
		List<AuthVO> authList = us.updateAuth(auth);
		return authList;
	}
	
	@GetMapping("boardList")
	public String boardList(@ModelAttribute("cri") SearchCriteria cri, Model model, Authentication auth) throws Exception {
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		MemberVO vo = user.getMember();
		int u_no = vo.getU_no();
		
		model.addAttribute("boardList", ms.getListById(cri, u_no));
		model.addAttribute("pageMaker", ms.getPageMaker(cri, u_no));
		return "mngt/boardList";
	}
	
	@PostMapping("deleteRow")
	@ResponseBody
	public String deleteRow(@RequestParam(value = "chbox1[]") List<Integer> checkBno, @RequestParam(value = "chbox2[]") List<String> checkBoardName, ListDTO dto) throws Exception {
		System.out.println(checkBno);
		System.out.println(checkBoardName);
		Map<String, Object> map = new HashMap<String, Object>();
		
		for(int i=0; i<checkBno.size(); i++) {
			map.put("bno", checkBno.get(i));
			map.put("boardName", checkBoardName.get(i));
			
			int bno = (int) map.get("bno");
			String boardName = (String) map.get("boardName");
			System.out.println("bno : "+bno+" / boardName : "+boardName);
			System.out.println("Map : "+map.toString());
			
			if(boardName.equals("notice")) {
				bs.remove(bno);
				System.out.println("공지 삭제");
			}else if(boardName.equals("main")){
				ibs.remove(bno);
				System.out.println("메인 삭제");
			}else if(boardName.equals("QnA")) {
				qs.remove(bno);
				System.out.println("QnA 삭제");
			}
		}
		return "delete";
	}
	/*
	 * 이 방법을 쓰지 않은 이유는 값을 하나만 받아와서 처리하기때문에 결과가 나가면 삭제된 게시물 숫자만큼 알림창이 뜨게 됨
	 * 
	@PostMapping("deleteRow")
	@ResponseBody
	public String deleteRow(@RequestParam(value = "chbox1") int checkBno, @RequestParam(value = "chbox2") String checkBoardName, ListDTO dto) throws Exception {
		System.out.println(checkBno);
		System.out.println(checkBoardName);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("bno", checkBno);
		map.put("boardName", checkBoardName);
		
		int bno = (int) map.get("bno");
		String boardName = (String) map.get("boardName");
		System.out.println("bno : "+bno+" / boardName : "+boardName);
		System.out.println("Map : "+map.toString());
		
		if(boardName.equals("notice")) {
			bs.remove(bno);
			System.out.println(bno);
			System.out.println("삭제 공지");
		}else if(boardName.equals("main")){
			ibs.remove(bno);
			System.out.println(bno);
			System.out.println("삭제 메인");
		}
		
		return "delete";
	}*/

}
