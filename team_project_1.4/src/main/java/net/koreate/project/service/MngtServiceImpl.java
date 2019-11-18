package net.koreate.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.project.dao.MngtDAO;
import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.BoardVO;

@Service
public class MngtServiceImpl implements MngtService {
	
	@Inject
	MngtDAO dao;

	@Override
	public List<BoardVO> getListById(SearchCriteria cri, int u_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("u_no", u_no);
		List<BoardVO> list = dao.getListById(map);
		return list;
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri, int u_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("u_no", u_no);
		System.out.println(cri.getKeyword());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listReplyCount(map));
		System.out.println("갯수 : "+dao.listReplyCount(map));
		return pageMaker;
	}

}
