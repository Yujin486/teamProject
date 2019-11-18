package net.koreate.project.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.koreate.project.dao.ReboardDAO;
import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.RegistDTO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	ReboardDAO dao;
	
	@Inject
	ServletContext context;
	
	@Override
	@Transactional
	public void registReply(RegistDTO regist) throws Exception {
		dao.register(regist);
		dao.updateOrigin();
		
		MultipartFile[] files = regist.getFiles();
		System.out.println(files);
		
		String path = context.getRealPath("/upload");
		
		System.out.println(files[0].getOriginalFilename());
		
		
		if(files != null) {
			for(MultipartFile filename : files) {
				if(filename.getOriginalFilename() != null && !filename.getOriginalFilename().equals("")) {
					String originalName = filename.getOriginalFilename();
					
					UUID uuid = UUID.randomUUID();
					String savedName = uuid.toString().replace("-", "")+"_"+originalName;
					
					String saveDir = File.separator+savedName;
					
					FileCopyUtils.copy(filename.getBytes(), new File(path,savedName));
					System.out.println("originalName : "+originalName);
					System.out.println("savedName : "+savedName);
					saveDir = saveDir.replace(File.separatorChar,'/');
					dao.addAttach(saveDir);
				}
			}
		}
		System.out.println("register 작업 완료");
	}

	@Override
	public List<BoardVO> listReply(SearchCriteria cri) throws Exception {
		List<BoardVO> list = dao.listReply(cri);
		return list;
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listReplyCount(cri));
		return pageMaker;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

	@Override
	public BoardVO readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}

	@Override
	public List<String> getAttach(int bno) throws Exception {
		return dao.getAttach(bno);
	}

	@Override
	@Transactional
	public void modify(BoardVO vo) throws Exception {
		//게시물 정보 업뎃
		dao.update(vo);
		//해당 번호 첨부파일 삭제
		dao.deleteAttach(vo.getBno());
		//파일 존재 확인
		String[] files = vo.getFiles();
		if(files == null) {return;}
		//map에 파일 정보 넣고 삽입
		for(String fullName : files) {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("bno", vo.getBno());
			paramMap.put("fullName", fullName);
			dao.replaceAttach(paramMap);
		}
	}

	@Override
	public void remove(int bno) throws Exception {
		dao.delete(bno);
		dao.deleteAttach(bno);
	}

	@Override
	@Transactional
	public void replyRegister(BoardVO vo) throws Exception {
		dao.updateReply(vo);
		System.out.println("넘어온 값 : "+vo);
		vo.setDepth(vo.getDepth()+1);
		vo.setSeq(vo.getSeq()+1);
		System.out.println("등록된 값 : "+vo);
		dao.replyRegister(vo);
	}

	@Override
	public BoardVO nextBoard(int bno, SearchCriteria cri) throws Exception {
		List<BoardVO> list = dao.listAll(cri);
		System.out.println(list.size());
		BoardVO board = null;
		//  0에 가까울수록 새글
		// 
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getBno() == bno) {
				if(i > 0) {
					bno=list.get(i-1).getBno();
					board =dao.readReply(bno);
					break;
				}
			}
		}
		return board;
	}

	@Override
	public BoardVO prevBoard(int bno, SearchCriteria cri) throws Exception {
		List<BoardVO> list = dao.listAll(cri);
		BoardVO board = null;
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getBno() == bno) {
				if(list.size()-1 >= i+1) {
					bno=list.get(i+1).getBno();
					board =dao.readReply(bno);
					break;
				}
			}
		}
		return board;
	}


}
