package net.koreate.project.controller;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

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

import net.koreate.project.service.BoardService;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.RegistDTO;

@Controller
@RequestMapping("/reboard/*")
public class ReboardController {
	
	@Inject
	BoardService service;
	
	@GetMapping("register")
	public String registerGet() {
		return "reboard/register";
	}

	@PostMapping("register")
	public String registerPost(RegistDTO regist) throws Exception{
		System.out.println("registerPost : "+regist);
		System.out.println(Arrays.toString(regist.getFiles()));
		service.registReply(regist);
		return "redirect:/reboard/listReply";
	}
	
	@GetMapping("listReply")
	public String listReply(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute("list", service.listReply(cri));
		model.addAttribute("pageMaker", service.getPageMaker(cri));
		return "reboard/listReply";
	}
	
	@GetMapping("readPage")
	public String readPage(SearchCriteria cri, @RequestParam("bno")int bno, RedirectAttributes rttr) throws Exception{
		service.updateCnt(bno);
		rttr.addAttribute("bno", bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/reboard/read";
	}
	
	@GetMapping("read")
	public String readPage(@ModelAttribute("cri") SearchCriteria cri, Model model, @RequestParam("bno") int bno) throws Exception{
		model.addAttribute("board", service.readReply(bno));
		System.out.println(service.readReply(bno));
		model.addAttribute("prevBoard", service.prevBoard(bno, cri));
		model.addAttribute("nextBoard", service.nextBoard(bno, cri));
		return "reboard/readPage";
	}
	
	@GetMapping("modifyPage")
	public String modifyPage(@RequestParam("bno")int bno, Model model) throws Exception {
		model.addAttribute("board", service.readReply(bno));
		return "reboard/modifyPage";
	}
	
	@PostMapping("modifyPage")
	public String modifyPage(BoardVO vo, RedirectAttributes rttr) throws Exception{
		System.out.println("modifyPage : "+vo);
		service.modify(vo);
		rttr.addAttribute("bno", vo.getBno());
		return "redirect:/reboard/read";
	}
	
	@PostMapping("remove")
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("page") int page) throws Exception{
		System.out.println(bno);
		service.remove(bno);
		return "redirect:/reboard/listReply";
	}
	
	@GetMapping("replyRegister")
	public String replyRegister(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		System.out.println("답글 작성 페이지 요청 : "+bno + " / cri : "+cri);
		model.addAttribute("board", service.readReply(bno));
		return "reboard/replyRegister";
	}
	
	@PostMapping("replyRegister")
	public String replyRegister(SearchCriteria cri, BoardVO vo, RedirectAttributes rttr) throws Exception{
		System.out.println(vo);
		service.replyRegister(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/reboard/listReply";
	}
	
	@GetMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno") int bno) throws Exception{
		return service.getAttach(bno);
	}
	
}
