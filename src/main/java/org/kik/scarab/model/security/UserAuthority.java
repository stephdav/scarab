package org.kik.scarab.model.security;

import org.springframework.security.core.GrantedAuthority;

public class UserAuthority implements GrantedAuthority {

	/** serialVersionUID */
	private static final long serialVersionUID = -5038658236685634708L;

	private String authority = "";

	public UserAuthority(final String authorityName) {
		this.authority = authorityName;
	}

	public String getAuthority() {
		return authority;
	}
}