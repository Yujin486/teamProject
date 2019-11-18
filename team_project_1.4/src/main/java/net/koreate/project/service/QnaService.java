package net.koreate.project.service;

import java.util.List;

import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.RegistDTO;

public interface QnaService {

	void registReply(RegistDTO regist) throws Exception;

	List<BoardVO> listReply(SearchCriteria cri) throws Exception;

	PageMaker getPageMaker(SearchCriteria cri) throws Exception;

	void updateCnt(int bno) throws Exception;

	BoardVO readReply(int bno) throws Exception;

	BoardVO prevBoard(int bno, SearchCriteria cri) throws Exception;

	BoardVO nextBoard(int bno, SearchCriteria cri) throws Exception;

	boolean checkPw(int bno, String password);

	List<String> getAttach(int bno) throws Exception;

	void modify(BoardVO vo) throws Exception;

	void remove(int bno) throws Exception;

	void replyRegister(BoardVO vo) throws Exception;

}
