package net.koreate.project.dao;

import java.util.List;
import java.util.Map;

import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.RegistDTO;

public interface QnaBoardDAO {

	void register(RegistDTO regist) throws Exception;

	void updateOrigin() throws Exception;

	void addAttach(String fullname) throws Exception;

	List<BoardVO> listReply(SearchCriteria cri) throws Exception;

	int listReplyCount(SearchCriteria cri) throws Exception;

	void updateCnt(int bno) throws Exception;

	BoardVO readReply(int bno) throws Exception;

	List<BoardVO> listAll(SearchCriteria cri) throws Exception;

	String pwCheck(int bno);

	List<String> getAttach(int bno) throws Exception;

	void update(BoardVO vo) throws Exception;

	void deleteAttach(int bno) throws Exception;

	void replaceAttach(Map<String, Object> paramMap) throws Exception;

	void delete(int bno) throws Exception;

	void updateReply(BoardVO vo) throws Exception;

	void replyRegister(BoardVO vo) throws Exception;

}
