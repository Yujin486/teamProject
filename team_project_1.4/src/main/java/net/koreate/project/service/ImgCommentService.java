package net.koreate.project.service;

import java.util.Map;

import net.koreate.project.vo.ImgCommentVO;

public interface ImgCommentService {

	// 댓글 등록
	void addComment(ImgCommentVO vo) throws Exception;

	// 댓글 수정
	void modifyComment(ImgCommentVO vo) throws Exception;

	// 댓글 삭제
	void removeComment(int cno) throws Exception;

	// 댓글 목록 & 페이징 처리 정보(List<CommentVO>, PageMaker)
	Map<String, Object> listPage(int bno, int page) throws Exception;
}
