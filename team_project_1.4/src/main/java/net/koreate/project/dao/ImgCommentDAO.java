package net.koreate.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import net.koreate.project.vo.ImgCommentVO;

@Repository
public interface ImgCommentDAO {

	@Insert("INSERT INTO img_comment(bno,commentText,commentAuth,uno) VALUES(#{bno},#{commentText},#{commentAuth},#{uno})")
	void addComment(ImgCommentVO vo) throws Exception;

	// 해당 게시글의 총 댓글 개수
	@Select("SELECT count(*) FROM img_comment WHERE bno = #{bno}")
	int totalCount(int bno) throws Exception;

	// 페이징 처리된 댓글 목록
	@Select("SELECT * FROM img_comment WHERE bno = #{bno} ORDER BY cno DESC limit #{cri.pageStart} , #{cri.perPageNum}")
	List<ImgCommentVO> listPage(Map<String, Object> paramMap) throws Exception;

	// 댓글 수정
	@Update("UPDATE img_comment SET commentText = #{commentText}, updatedate = now() WHERE cno = #{cno}")
	void modifyComment(ImgCommentVO vo);

	// 댓글 삭제
	@Delete("DELETE FROM img_comment WHERE cno = #{cno}")
	void removeComment(int cno);

	@Delete("DELETE FROM img_comment WHERE bno = #{bno}")
	void deleteComments(int bno);

}
