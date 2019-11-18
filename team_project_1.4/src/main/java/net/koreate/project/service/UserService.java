package net.koreate.project.service;

import java.util.List;
import java.util.Map;

import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.AuthVO;
import net.koreate.project.vo.MemberVO;

public interface UserService {
	
	void join(MemberVO vo) throws Exception;

	boolean getMemberById(String u_id);

	// 활성화 여부
    void deleteYN(MemberVO vo);

	void updateVisitDate(String u_id);

	List<MemberVO> getMemberById(SearchCriteria cri) throws Exception;

	List<AuthVO> updateAuth(AuthVO auth) throws Exception;

	PageMaker getPageMaker(SearchCriteria cri) throws Exception;

	MemberVO getMember(String username);

	void passwordModify(MemberVO vo) throws Exception;

	boolean checkPw(String new_pw, String old_pw);	

	void profileModify(MemberVO vo) throws Exception;

	void mngtDeleteYN(MemberVO vo);

	void naverJoin(Map<String, String> naverLogin);

}
