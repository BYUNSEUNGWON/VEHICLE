package com.bsw.vehicle.login.service;

public interface LoginService {

	boolean validateUser(String userId, String password);

	int checkUserId(String userId);

}
