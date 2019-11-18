package net.koreate.project.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.project.dao.MemberDAO;
import net.koreate.project.security.CustomUser;
import net.koreate.project.util.PageMaker;
import net.koreate.project.util.SearchCriteria;
import net.koreate.project.vo.AuthVO;
import net.koreate.project.vo.MemberVO;

@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	MemberDAO dao;

	@Inject
	PasswordEncoder password;
	
	@Override
	@Transactional
	public void join(MemberVO vo) throws Exception {
		System.out.println(vo.getU_pw());
		vo.setU_pw(password.encode(vo.getU_pw()));
		System.out.println(vo.getU_pw());
		dao.join(vo);
		dao.addAuth(vo.getU_id());
	}

	@Override
	public boolean getMemberById(String u_id) {
		boolean isChecked = true;
		System.out.println("첫번째로 아이디 확인중");
		if(dao.getMemberBYId(u_id) != null) {
			isChecked = false;
		}
		System.out.println(isChecked);
		return isChecked;
	}

	@Override
	public void deleteYN(MemberVO vo) {
		dao.deleteYN(vo);
	}

	@Override
	public void updateVisitDate(String u_id) {
		dao.updateVisitDate(u_id);
	}


	@Override
	public List<MemberVO> getMemberById(SearchCriteria cri) throws Exception {
		return dao.getMemberList(cri);
	}

	@Transactional
	@Override
	public List<AuthVO> updateAuth(AuthVO auth) throws Exception {
		ArrayList<AuthVO> beforeList = dao.getAuthList(auth.getU_id());
		
		boolean isNull = true;
		for(AuthVO a : beforeList) {
			if(auth.getAuth().equals(a.getAuth())) {
				dao.deleteAuth(a);
				isNull = false;
				break;
			}
		}
		
		if(isNull) {
			dao.insertMemberAuth(auth);
		}
		
		ArrayList<AuthVO> afterList = dao.getAuthList(auth.getU_id());
		return afterList;
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.memberCount(cri));
		return pageMaker;
	}

	@Override
	public MemberVO getMember(String username) {
		return dao.getMember(username);
	}

	@Override
	public void passwordModify(MemberVO vo) throws Exception {
		System.out.println("passModify serviceImpl");	
		System.out.println("plain Pass : "+vo.getU_pw());
		String plainPass = vo.getU_pw();
		vo.setU_pw(password.encode(vo.getU_pw()));
		System.out.println("bcrypt pass : "+vo.getU_pw());
		System.out.println("암호 동일 여부 : "+password.matches(plainPass, vo.getU_pw()));
		dao.passwordModify(vo);
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		user.setMember(getMember(user.getUsername()));
	}

	@Override
	public boolean checkPw(String new_pw, String old_pw) {
		boolean isChecked = false;
		System.out.println(new_pw);
		System.out.println("check :" +password.matches(new_pw, old_pw));
		if(password.matches(new_pw, old_pw)) {			
			isChecked = true;
		}
		return isChecked;
	}

	@Override
	public void profileModify(MemberVO vo) throws Exception {
		System.out.println("profileModify serviceImpl");
		dao.profileModify(vo);
		//시큐리티 정보 업데이트. 우선 시큐리티에 저장되어 있는 principal 정보를 들고와서 user에 넣어줌.
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//변경된 데이터를 다시 시큐리티 principal에 set해줌.
		user.setMember(getMember(user.getUsername()));	
	}

	@Override
	public void mngtDeleteYN(MemberVO vo) {
		dao.mngtDeleteYN(vo);
	}
	
	@Transactional
	@Override
	public void naverJoin(Map<String, String> naverLogin) {
		System.out.println("회원가입중");
		System.out.println(naverLogin.get("sns_id"));
		String pw = "asdf123";
		naverLogin.put("sns_pw", password.encode(pw));
		dao.naverJoin(naverLogin);
		System.out.println("권한 주는중");
		dao.addAuth(naverLogin.get("sns_id"));
	}
	
}
