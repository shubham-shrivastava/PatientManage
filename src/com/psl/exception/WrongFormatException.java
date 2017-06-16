package com.psl.exception;

public class WrongFormatException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	public WrongFormatException(String s) {
		// TODO Auto-generated constructor stub
		super(s);
		System.out.println(s);
	}
	
}
