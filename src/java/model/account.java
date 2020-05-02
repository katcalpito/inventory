/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Guest
 */
public class account {
    public String username;
    public String name;
    public String level;
    public String mobile;
    
    
    public void setDetails(String username, String name, String level, String mobile){
        this.username = username;
        this.name =  name;
        this.level = level;
        this.mobile = mobile;
    }
}
