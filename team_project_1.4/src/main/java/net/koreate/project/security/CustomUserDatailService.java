package net.koreate.project.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import net.koreate.project.dao.MemberDAO;
import net.koreate.project.vo.MemberVO;

//사용자상세정보
public class CustomUserDatailService implements UserDetailsService  {

	@Inject
	MemberDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO vo = null;
		System.out.println("loadUserByUsername");
		System.out.println("username :"+username);
		
		try {
			vo = dao.read(username);
			System.out.println("quired by Member :" +vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return vo == null ? null : new CustomUser(vo) ;
	}

	

}
