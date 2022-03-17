/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.partner;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class Customer {

    private int customerID;
    private String customerName;
    private boolean gender;
    private Date dob;
    private String phone;
    private String address;
    private String description;

    public Customer() {
    }

    public Customer(String customerName, boolean gender, Date dob, String phone, String address, String description) {
        this.customerName = customerName;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.description = description;
    }

    public Customer(int customerID, String customerName, boolean gender, Date dob, String phone, String address, String description) {
        this.customerID = customerID;
        this.customerName = customerName;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.description = description;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
