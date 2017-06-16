package com.psl.model;

public class Message {

	String msg;
	boolean successful;
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public boolean isSuccessful() {
		return successful;
	}
	public void setSuccessful(boolean successful) {
		this.successful = successful;
	}
	public Message(String msg, boolean successful) {
		super();
		this.msg = msg;
		this.successful = successful;
	}
	
}
