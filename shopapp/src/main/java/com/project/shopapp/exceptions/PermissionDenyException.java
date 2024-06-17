package com.project.shopapp.exceptions;

public class PermissionDenyException extends Exception{
    public PermissionDenyException(String msg){
        super(msg);
    }
}
