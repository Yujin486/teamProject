package net.koreate.project.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;
import net.koreate.project.vo.AuthVO;
import net.koreate.project.vo.MemberVO;

@Getter
@Setter
public class CustomUser extends User {
	
 private static final long serialVersionUID = 1L;
	
	private MemberVO member;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getU_id(), vo.getU_pw(),customAuthories(vo.getAuthList()));
		this.member = vo;
	}

	private static Collection<? extends GrantedAuthority> customAuthories(List<AuthVO> list) {
		List<GrantedAuthority> authorities = new ArrayList<>();
		for(AuthVO auth : list) {
			authorities.add(new SimpleGrantedAuthority(auth.getAuth()));
		}
		return authorities;
	}
	
}
