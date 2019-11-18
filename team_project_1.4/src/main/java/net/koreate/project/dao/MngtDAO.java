package net.koreate.project.dao;

import java.util.List;
import java.util.Map;

import net.koreate.project.vo.BoardVO;

public interface MngtDAO {

	List<BoardVO> getListById(Map<String, Object> map);

	int listReplyCount(Map<String, Object> map);

}
