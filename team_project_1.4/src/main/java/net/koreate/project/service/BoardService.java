package net.koreate.project.service;

import java.util.List;

import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.RegistDTO;

public interface BoardService {
	
	//글 등록
	void registReply(RegistDTO regist) throws Exception;
	
	//게시글 목록
	List<BoardVO> listReply(SearchCriteria cri) throws Exception;
	
	//페이징 블럭 정보
	PageMaker getPageMaker(SearchCriteria cri) throws Exception;
	
	//조회수 증가
	void updateCnt(int bno) throws Exception;

	BoardVO readReply(int bno) throws Exception;

	List<String> getAttach(int bno) throws Exception;

	void modify(BoardVO vo) throws Exception;

	void remove(int bno) throws Exception;

	void replyRegister(BoardVO vo) throws Exception;
	
	//다음글
	BoardVO nextBoard(int bno, SearchCriteria cri) throws Exception;
	
	//이전글
	BoardVO prevBoard(int bno, SearchCriteria cri) throws Exception;

}
