package com.psl.model;



public class Patient {
	
	private int id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	private String AccNo;
	private String firstName;
	public String getAccNo() {
		return AccNo;
	}
	public void setAccNo(String accNo) {
		AccNo = accNo;
	}
	private String lastName;
	private String facility;
	private String admitDate;
	private String dischargeDate;
	private String deleted;
	
	@Override
	public String toString() {
		return "Patient [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", facility=" + facility
				+ ", admitDate=" + admitDate + ", dischargeDate=" + dischargeDate + ", deleted=" + deleted + "]";
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getAdmitDate() {
		return admitDate;
	}
	
	public Patient(String accNo, String firstName, String lastName, String facility, String admitDate,
			String dischargeDate) {
		super();
		AccNo = accNo;
		this.firstName = firstName;
		this.lastName = lastName;
		this.facility = facility;
		this.admitDate = admitDate;
		this.dischargeDate = dischargeDate;
	}
	public void setAdmitDate(String admitDate) {
		this.admitDate = admitDate;
	}
	public String getDischargeDate() {
		return dischargeDate;
	}
	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}
	public String getLastName() {
		return lastName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getFacility() {
		return facility;
	}
	public void setFacility(String facility) {
		this.facility = facility;
	}
	
	public Patient() {
		super();
	}
	
	public Patient(int id, String accNo, String firstName, String lastName, String facility, String admitDate,
			String dischargeDate, String deleted) {
		super();
		this.id = id;
		AccNo = accNo;
		this.firstName = firstName;
		this.lastName = lastName;
		this.facility = facility;
		this.admitDate = admitDate;
		this.dischargeDate = dischargeDate;
		this.deleted = deleted;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
}
