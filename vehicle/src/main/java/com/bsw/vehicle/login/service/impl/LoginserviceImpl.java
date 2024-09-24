package com.bsw.vehicle.login.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bsw.vehicle.login.service.LoginService;
import com.bsw.vehicle.mapper.LoginMapper;
import com.bsw.vehicle.mapper.PromotionMapper;

@Service
public class LoginserviceImpl implements LoginService{
	
	@Autowired
	LoginMapper loginMapper;
	

	@Override
	public boolean validateUser(String userId, String password) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int checkUserId(String userId) {
		int result = loginMapper.checkUserId(userId);
		return result;
	}

}
