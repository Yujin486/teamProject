package net.koreate.project.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.AuthVO;
import net.koreate.project.vo.LoginDTO;
import net.koreate.project.vo.MemberVO;

public interface MemberDAO {

	void join(MemberVO vo);

	MemberVO getMemberBYId(String u_id);

	void deleteYN(MemberVO vo);

	MemberVO read(String username);

	void addAuth(String u_id);

	MemberVO signIn(LoginDTO dto);

	void updateVisitDate(String u_id);

	List<MemberVO> getMemberList(SearchCriteria cri);

	ArrayList<AuthVO> getAuthList(String u_id);

	void deleteAuth(AuthVO a);

	void insertMemberAuth(AuthVO auth);

	int memberCount(SearchCriteria cri) throws Exception;

	void profileModify(MemberVO vo);

	MemberVO getMember(String username);

	void passwordModify(MemberVO vo);

	int checkPw(String u_pw);

	void mngtDeleteYN(MemberVO vo);

	void naverJoin(Map<String, String> naverLogin);

}
