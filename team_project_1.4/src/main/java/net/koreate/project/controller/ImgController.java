package net.koreate.project.controller;

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

import net.koreate.project.service.ImgBoardService;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.ImgBoardVO;

@Controller
@RequestMapping("/imgboard/*")
public class ImgController {

	@Inject
	ImgBoardService service;

	@GetMapping("imgRegister")
	public String registerGet() {
		return "imgboard/imgRegister";
	}

	@PostMapping("imgRegister")
	public String registerPost(ImgBoardVO board) throws Exception {
		System.out.println("registerPost : " + board);
		service.regist(board);
		service.profileAttach(board.getBno());

		return "redirect:/imgboard/imgBoardList";
	}

	@GetMapping("imgBoardList")
	public String imgList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		// 검색 조건에 맞는 페이징 처리된 게시물 항목(한번에 client로 보여줄 게시물)
		model.addAttribute("list", service.listCriteria(cri));
		// 페이징 블럭 정보
		model.addAttribute("pageMaker", service.getPageMaker(cri));
		return "imgboard/imgBoardList";
	}

	@GetMapping("imgViewPage")
	public String viewPage(SearchCriteria cri, @RequestParam("bno") int bno, RedirectAttributes rttr) throws Exception {
		
		// 조회수 증가
		service.updateCnt(bno);
		rttr.addAttribute("bno", bno);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		System.out.println("readPage : " + cri);

		return "redirect:/imgboard/imgView";
	}

	@GetMapping("imgView")
	public String viewPage(@ModelAttribute("cri") SearchCriteria cri, Model model, @RequestParam("bno") int bno)
			throws Exception {

		// 게시물 정보

		System.out.println("read : " + cri);
		model.addAttribute("imgBoardVO", service.view(bno));
		model.addAttribute("prevBoard", service.prevBoard(bno, cri));
		model.addAttribute("nextBoard", service.nextBoard(bno, cri));
		
		return "imgboard/imgViewPage";
	}

	@GetMapping("imgModifyPage")
	public String modifyPage(@RequestParam("bno") int bno, Model model) throws Exception {
		model.addAttribute("imgBoardVO", service.view(bno));
		return "imgboard/imgModifyPage";
	}

	@PostMapping("imgModifyPage")
	public String modifyPage(ImgBoardVO vo, RedirectAttributes rttr) throws Exception {
		System.out.println("modifyPage : " + vo);
		service.profileAttach(vo.getBno());
		service.modify(vo);
		rttr.addAttribute("bno", vo.getBno());
	
		return "redirect:/imgboard/imgBoardList";
	}

	@PostMapping("remove")
	public String remove(@RequestParam("bno") int bno) throws Exception {
		service.remove(bno);
		System.out.println("bno : "+bno);
		return "redirect:/imgboard/imgBoardList";
	}

	@GetMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable(name = "bno", required = false) int bno) throws Exception {
		System.out.println("getAttach : " + bno);
		return service.getAttach(bno);
	}

	/*
	 * @GetMapping("/profileAttach/{bno}")
	 * 
	 * @ResponseBody public ResponseEntity<String> profileAttach(@PathVariable(name
	 * = "bno", required = false) int bno){ ResponseEntity<String> entity = null;
	 * String result= null; try { System.out.println("profileAttach : " + bno);
	 * result = service.profileAttach(bno); System.out.println("result : " +
	 * result); entity = new ResponseEntity<>(result,HttpStatus.OK); } catch
	 * (Exception e) { e.printStackTrace(); entity = new
	 * ResponseEntity<>("error",HttpStatus.OK); } return entity; }
	 */

	/*
	 * @GetMapping("/profileAttach")
	 * 
	 * @ResponseBody public ResponseEntity<String>
	 * profileAttach(@RequestParam("bno") int bno) { ResponseEntity<String> entity =
	 * null; String result = null; try { result = service.profileAttach(bno);
	 * System.out.println("result : " + result); entity = new
	 * ResponseEntity<>(result, HttpStatus.OK); } catch (Exception e) {
	 * e.printStackTrace(); entity = new ResponseEntity<>("error", HttpStatus.OK); }
	 * return entity; }
	 */
}
