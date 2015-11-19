package org.kik.scarab.service.exception;

public class FunctionalException extends Exception {

	/** serialVersionUID */
	private static final long serialVersionUID = -2617648567241308464L;

	/**
	 * {@link Exception#Exception(String)}
	 *
	 * @param message
	 *            the detail message. The detail message is saved for later
	 *            retrieval by the {@link #getMessage()} method.
	 */
	public FunctionalException(String message) {
		super(message);
	}

	/**
	 * {@link Exception#Exception(String, Throwable)}
	 *
	 * @param message
	 *            the detail message (which is saved for later retrieval by the
	 *            {@link #getMessage()} method).
	 * @param cause
	 *            the cause (which is saved for later retrieval by the
	 *            {@link #getCause()} method). (A <tt>null</tt> value is
	 *            permitted, and indicates that the cause is nonexistent or
	 *            unknown.)
	 */
	public FunctionalException(String message, Throwable cause) {
		super(message, cause);
	}
}
