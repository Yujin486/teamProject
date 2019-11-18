package net.koreate.project.service;

import java.util.List;

import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;

public interface MngtService {

	List<BoardVO> getListById(SearchCriteria cri, int u_no) throws Exception;

	PageMaker getPageMaker(SearchCriteria cri, int u_no) throws Exception;

}
