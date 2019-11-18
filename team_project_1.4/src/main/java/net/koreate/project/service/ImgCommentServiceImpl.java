package net.koreate.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import net.koreate.project.dao.ImgCommentDAO;
import net.koreate.project.util.Criteria;
import net.koreate.project.util.PageMaker;
import net.koreate.project.vo.ImgCommentVO;

@Service
public class ImgCommentServiceImpl implements ImgCommentService {
	@Inject
	ImgCommentDAO dao;

	@Override
	public void addComment(ImgCommentVO vo) throws Exception {
		dao.addComment(vo);
	}

	@Override
	public void modifyComment(ImgCommentVO vo) throws Exception {
		dao.modifyComment(vo);
	}

	@Override
	public void removeComment(int cno) throws Exception {
		dao.removeComment(cno);

	}

	@Override
	public Map<String, Object> listPage(int bno, int page) throws Exception {
		Map<String, Object> map = new HashMap<>();
		PageMaker pageMaker = getPageMaker(bno, page);
		map.put("pageMaker", pageMaker);

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("bno", bno);
		paramMap.put("cri", pageMaker.getCri());

		List<ImgCommentVO> list = dao.listPage(paramMap);
		map.put("list", list);
		return map;
	}

	PageMaker getPageMaker(int bno, int page) throws Exception {
		PageMaker pageMaker = new PageMaker();

		Criteria cri = new Criteria();
		cri.setPage(page);

		pageMaker.setCri(cri);
		int totalCount = dao.totalCount(bno);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

}
