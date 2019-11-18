package net.koreate.project.controller;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.project.util.UploadUtils;

@Controller
public class FileController {
	
	@Inject
	ServletContext context;
	
	@GetMapping("/displayFiles")
	@ResponseBody
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		System.out.println(fileName);
		UploadUtils utils = UploadUtils.getInstance(context);
		return new ResponseEntity<byte[]>(utils.getBytes(fileName), utils.getHeaders(fileName), HttpStatus.OK);
	}
	
	@PostMapping("/deleteFileA")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName) throws Exception{
		System.out.println(fileName);
		UploadUtils utils = UploadUtils.getInstance(context);
		// 삭제처리
		return new ResponseEntity<String>(utils.deleteFileA(fileName), HttpStatus.OK);
	}
	
	@PostMapping("deleteAllFilesA")
	public ResponseEntity<String> deleteAllFilesA(@RequestParam("files[]") String[] files){
		System.out.println("삭제 : deleteAllFilesA");
		UploadUtils utils = UploadUtils.getInstance(context);
		return new ResponseEntity<>(utils.deleteAllFilesA(files), HttpStatus.OK);
	}
}
