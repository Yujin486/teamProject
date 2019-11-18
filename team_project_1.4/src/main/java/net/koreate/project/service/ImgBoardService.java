package net.koreate.project.service;

import java.util.List;
import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.ImgBoardVO;

public interface ImgBoardService {
	// 게시물 작성
	void regist(ImgBoardVO board) throws Exception;

	// 검색 결과에 따른 페이징 처리된 게시물 리스트
	List<ImgBoardVO> listCriteria(SearchCriteria cri) throws Exception;

	// 페이징 블럭 정보
	PageMaker getPageMaker(SearchCriteria cri) throws Exception;

	// 게시물 상세보기
	ImgBoardVO view(int bno) throws Exception;

	// 첨부 파일 목록
	List<String> getAttach(int bno) throws Exception;

	// 대표 이미지
	String profileAttach(int bno) throws Exception;
	/* String profileAttach() throws Exception; */

	// 게시물 삭제
	void remove(int bno) throws Exception;

	// 게시물 수정
	void modify(ImgBoardVO vo) throws Exception;

	void updateCnt(int bno);

	ImgBoardVO nextBoard(int bno, SearchCriteria cri) throws Exception;

	ImgBoardVO prevBoard(int bno, SearchCriteria cri) throws Exception;

}
