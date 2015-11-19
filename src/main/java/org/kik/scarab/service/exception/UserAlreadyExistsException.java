package org.kik.scarab.service.exception;

public class UserAlreadyExistsException extends RuntimeException {

	/** serialVersionUID */
	private static final long serialVersionUID = 8142240497357446221L;

	public UserAlreadyExistsException(final String message) {
		super(message);
	}
}
