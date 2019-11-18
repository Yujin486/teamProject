package net.koreate.project.security;

import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoopPasswordEncoder implements PasswordEncoder {

	@Override
	public String encode(CharSequence rawPassword) {
		
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		System.out.println("matches : "+rawPassword+"//"+encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}

}
