package org.kik.scarab.model.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class ScarabUser extends User {

	/** serialVersionUID */
	private static final long serialVersionUID = -4907670482761751701L;

	long id;

	public ScarabUser(long id, final String username, final String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, true, true, true, true, authorities);
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

}
