package net.koreate.project.dao;

import java.util.List;
import java.util.Map;

import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.ImgBoardVO;

public interface ImgBoardDAO {

	// 게시물 등록
	void register(ImgBoardVO board) throws Exception;

	void updateOrigin();

	void addAttach(String fullName);

	List<ImgBoardVO> listCriteria(SearchCriteria cri);

	int listCount(SearchCriteria cri);

	ImgBoardVO view(int bno);

	void delete(int bno);

	void deleteAttach(int bno);

	void update(ImgBoardVO vo);

	void replaceAttach(Map<String, Object> paramMap);

	void updateCnt(int bno);

	List<ImgBoardVO> listAll(SearchCriteria cri);

	List<String> getAttach(int bno);

	String profileAttach(int bno);
	/* String profileAttach(); */
}
