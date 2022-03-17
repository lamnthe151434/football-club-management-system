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
public class Supplier {

    private int supplierID;
    private String supplierName;
    private boolean gender;
    private Date dob;
    private String phone;
    private String address;
    private String description;

    public Supplier() {
    }

    public Supplier(String supplierName, boolean gender, Date dob, String phone, String address, String description) {
        this.supplierName = supplierName;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.description = description;
    }

    public Supplier(int supplierID, String supplierName, boolean gender, Date dob, String phone, String address, String description) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.description = description;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
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
