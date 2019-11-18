package net.koreate.project.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.project.service.ImgCommentService;
import net.koreate.project.vo.ImgCommentVO;

@RestController
@RequestMapping("/comments")
public class ImgCommentController {

	@Inject
	ImgCommentService cs;

	@PostMapping("/add")
	public ResponseEntity<String> addComment(@RequestBody ImgCommentVO vo) {
		System.out.println("comment add : " + vo);
		ResponseEntity<String> entity = null;
		try {
			cs.addComment(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// /comments/bno/page
	@GetMapping("/{bno}/{page}")
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno") int bno, @PathVariable("page") int page) {
		ResponseEntity<Map<String, Object>> entity = null;
		// 보여줄 댓글 리스트 & pageMaker
		try {
			Map<String, Object> map = cs.listPage(bno, page);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 댓글 수정
	// /comments/{cno}
	@PatchMapping("/{cno}/{uno}")
	public ResponseEntity<String> update(@PathVariable("cno") int cno, @PathVariable("uno") int uno, @RequestBody ImgCommentVO vo) {
		System.out.println(cno + " // " + vo);
		ResponseEntity<String> entity = null;
		try {
			vo.setCno(cno);
			vo.setUno(uno);
			cs.modifyComment(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@DeleteMapping("/{cno}")
	public ResponseEntity<String> delete(@PathVariable("cno") int cno) {
		//System.out.println("delete cno : " + cno + "/ uno : " + uno);
		System.out.println("delete cno : " + cno);
		ResponseEntity<String> entity = null;
		try {
			cs.removeComment(cno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
