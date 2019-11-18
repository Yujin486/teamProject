package net.koreate.project.controller;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.project.security.CustomUser;
import net.koreate.project.service.QnaService;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.MemberVO;
import net.koreate.project.vo.RegistDTO;

@Controller
@RequestMapping("/qnaboard/*")
public class QnaController {
	
	@Inject
	QnaService service;
	
	@GetMapping("register")
	public String registerGet() {
		return "qnaboard/register";
	}
	
	@PostMapping("register")
	public String registerPost(RegistDTO regist) throws Exception {
		System.out.println("registerPost : "+regist);
		System.out.println(Arrays.toString(regist.getFiles()));
		service.registReply(regist);
		return "redirect:/qnaboard/listReply";
	}
	
	@GetMapping("listReply")
	public String listReply(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute("list", service.listReply(cri));
		model.addAttribute("pageMaker", service.getPageMaker(cri));
		return "qnaboard/listReply";
	}
	
	@GetMapping("pwConfirmPage")
	public String pwConfirmPage(@ModelAttribute("cri") SearchCriteria cri, Model model, @RequestParam("bno") int bno, Authentication auth, RedirectAttributes rttr) throws Exception{
		CustomUser user = (CustomUser) auth.getPrincipal();
		MemberVO vo = user.getMember();
		String addr = "";
		if (2 <= vo.getAuthList().size() || 1 <= service.readReply(bno).getDepth()) {
			addr = "redirect:/qnaboard/readPage";
		}else {
			addr = "qnaboard/pwConfirm";
		}
		model.addAttribute("board", service.readReply(bno));
		model.addAttribute("prevBoard", service.prevBoard(bno, cri));
		model.addAttribute("nextBoard", service.nextBoard(bno, cri));
		rttr.addAttribute("bno", bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		return addr;
	}
	
	@PostMapping("pwConfirm")
	public String pwConfirm(SearchCriteria cri, @RequestParam("bno")int bno, String password, RedirectAttributes rttr) {
		System.out.println("비밀번호 : "+ password);
		boolean check = service.checkPw(bno, password);
		System.out.println(check);
		String address = "";
		if(check) {
			address = "redirect:/qnaboard/readPage";
		}else {
			address = "redirect:/qnaboard/pwConfirmPage";
			rttr.addFlashAttribute("message", "비밀번호가 틀렸습니다.");
		}
		rttr.addAttribute("bno", bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		return address;
	}
	
	@GetMapping("readPage")
	public String readPage(SearchCriteria cri, @RequestParam("bno")int bno, RedirectAttributes rttr) throws Exception{
		service.updateCnt(bno);
		rttr.addAttribute("bno", bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/qnaboard/read";
	}
	
	@GetMapping("read")
	public String readPage(@ModelAttribute("cri") SearchCriteria cri, Model model, @RequestParam("bno") int bno) throws Exception{
		model.addAttribute("board", service.readReply(bno));
		System.out.println(service.readReply(bno));
		model.addAttribute("prevBoard", service.prevBoard(bno, cri));
		model.addAttribute("nextBoard", service.nextBoard(bno, cri));
		return "qnaboard/readPage";
	}
	
	@GetMapping("modifyPage")
	public String modifyPage(@RequestParam("bno")int bno, Model model) throws Exception {
		model.addAttribute("board", service.readReply(bno));
		return "qnaboard/modifyPage";
	}
	
	@GetMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno") int bno) throws Exception{
		return service.getAttach(bno);
	}
	
	@PostMapping("modifyPage")
	public String modifyPage(BoardVO vo, RedirectAttributes rttr) throws Exception{
		System.out.println("modifyPage : "+vo);
		service.modify(vo);
		rttr.addAttribute("bno", vo.getBno());
		return "redirect:/qnaboard/read";
	}
	
	@PostMapping("remove")
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("page") int page) throws Exception{
		System.out.println(bno);
		service.remove(bno);
		return "redirect:/qnaboard/listReply";
	}
	
	@GetMapping("replyRegister")
	public String replyRegister(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("답글 작성 페이지 요청 : "+bno + " / cri : "+cri);
		model.addAttribute("board", service.readReply(bno));
		return "qnaboard/replyRegister";
	}
	
	@PostMapping("replyRegister")
	public String replyRegister(SearchCriteria cri, BoardVO vo, RedirectAttributes rttr) throws Exception{
		System.out.println(vo);
		service.replyRegister(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/qnaboard/listReply";
	}

}
