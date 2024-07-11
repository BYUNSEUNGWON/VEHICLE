package com.bsw.vehicle.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bsw.vehicle.common.service.CommonService;

@Service
public class CommonServiceImpl implements CommonService{

	@Override
	public List<String> menu() throws Exception {
		List<String> menu = new ArrayList<>();
		menu.add("홈");
		menu.add("공지사항");
		menu.add("소개");
		menu.add("자유게시판");
		return menu;
	}

}
