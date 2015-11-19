package org.kik.scarab.service;

import java.util.ArrayList;
import java.util.List;

import org.kik.scarab.dao.UserRepository;
import org.kik.scarab.model.security.UserAuthority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserRepository userdao;

	public UserDetailsServiceImpl() {
		// Empty constructor
	}

	@Override
	public UserDetails loadUserByUsername(String userId)
			throws UsernameNotFoundException {

		org.kik.scarab.model.User userEntity = userdao
				.findFirstByUsername(userId);
		if (userEntity == null) {
			throw new UsernameNotFoundException("user name not found");
		}

		return buildUserFromUserEntity(userEntity);

	}

	private User buildUserFromUserEntity(org.kik.scarab.model.User userEntity) {

		// convert model user to spring security user
		String username = userEntity.getUsername();
		String password = userEntity.getPassword();

		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new UserAuthority(userEntity.getRole()));

		return new User(username, password, enabled, accountNonExpired,
				credentialsNonExpired, accountNonLocked, authorities);
	}
}