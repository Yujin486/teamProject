package net.koreate.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.project.dao.ImgCommentDAO;
import net.koreate.project.dao.ImgBoardDAO;
import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.ImgBoardVO;

@Service
public class ImgBoardServiceImpl implements ImgBoardService {

	@Inject
	ImgBoardDAO dao;

	@Inject
	ImgCommentDAO commentDAO;

	@Override
	public void regist(ImgBoardVO board) throws Exception {
		// 게시물 등록 / origin update / 첨부파일 등록
		dao.register(board);
		dao.updateOrigin();
		String[] files = board.getFiles();
		if (files == null) {
			return;
		}
		for (String fullName : files) {
			dao.addAttach(fullName);
		}
		System.out.println("register 작업 완료");

	}

	@Override
	public List<ImgBoardVO> listCriteria(SearchCriteria cri) throws Exception {
		List<ImgBoardVO> list = dao.listCriteria(cri);

		for (ImgBoardVO board : list) {
			board.setCommentCnt(commentDAO.totalCount(board.getBno()));
		}
		return list;
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listCount(cri));
		return pageMaker;
	}

	@Override
	public ImgBoardVO view(int bno) throws Exception {

		return dao.view(bno);
	}

	@Override
	public List<String> getAttach(int bno) {
		return dao.getAttach(bno);
	}

	/*
	 * @Override public String profileAttach(int bno) { return
	 * dao.profileAttach(bno); }
	 */
	@Override
	public String profileAttach(int bno) {
		return dao.profileAttach(bno);
	}

	@Override
	@Transactional
	public void remove(int bno) throws Exception {
		// 댓글 삭제
		commentDAO.deleteComments(bno);
		// 첨부파일 삭제
		dao.deleteAttach(bno);
		// 게시글 삭제
		dao.delete(bno);
		
		
	}

	@Override
	@Transactional
	public void modify(ImgBoardVO vo) {
		// 게시물 정보 갱신
		dao.update(vo);
		// 첨부된 파일 정보 갱신
		dao.deleteAttach(vo.getBno());

		String[] files = vo.getFiles();
		// 첨부 파일이 없을 경우
		if (files == null) {
			return;
		}
		// 파일이 남아 있을 경우
		for (String fullName : files) {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("bno", vo.getBno());
			paramMap.put("fullName", fullName);
			dao.replaceAttach(paramMap);
		}

	}

	// 조회 수 증가
	@Override
	public void updateCnt(int bno) {
		dao.updateCnt(bno);

	}

	@Override
	public ImgBoardVO nextBoard(int bno, SearchCriteria cri) throws Exception {
		List<ImgBoardVO> list = dao.listAll(cri);
		System.out.println(list.size());
		ImgBoardVO board = null;
		// 0에 가까울수록 새글
		//
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBno() == bno) {
				if (i > 0) {
					bno = list.get(i - 1).getBno();
					board = dao.view(bno);
					break;
				}
			}
		}
		return board;
	}

	@Override
	public ImgBoardVO prevBoard(int bno, SearchCriteria cri) throws Exception {
		List<ImgBoardVO> list = dao.listAll(cri);
		ImgBoardVO board = null;
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBno() == bno) {
				if (list.size() - 1 >= i + 1) {
					bno = list.get(i + 1).getBno();
					board = dao.view(bno);
					break;
				}
			}
		}
		return board;
	}

}
