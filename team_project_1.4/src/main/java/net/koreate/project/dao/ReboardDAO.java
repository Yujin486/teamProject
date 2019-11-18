package net.koreate.project.dao;

import java.util.List;
import java.util.Map;

import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;
import net.koreate.project.vo.RegistDTO;

public interface ReboardDAO {

	void register(RegistDTO regist) throws Exception;

	void updateOrigin() throws Exception;

	void addAttach(String fullname) throws Exception;

	List<BoardVO> listReply(SearchCriteria cri) throws Exception;

	int listReplyCount(SearchCriteria cri) throws Exception;

	void updateCnt(int bno) throws Exception;

	BoardVO readReply(int bno) throws Exception;

	List<String> getAttach(int bno) throws Exception;
	
	//게시물 정보 수정
	void update(BoardVO vo) throws Exception;
	
	//첨부파일 삭제하고
	void deleteAttach(int bno) throws Exception;
	
	//다시 첨부파일 넣기
	void replaceAttach(Map<String, Object> paramMap) throws Exception;
	
	//게시물 삭제
	void delete(int bno) throws Exception;
	
	//원본 글 정렬 순서 수정
	void updateReply(BoardVO vo) throws Exception;
	
	//게시물 등록
	void replyRegister(BoardVO vo) throws Exception;

	List<BoardVO> listAll(SearchCriteria cri) throws Exception;

}
