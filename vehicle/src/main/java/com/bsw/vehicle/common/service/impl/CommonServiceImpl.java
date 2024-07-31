package com.bsw.vehicle.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bsw.vehicle.common.service.CommonService;
import com.bsw.vehicle.mapper.RepairMapper;
import com.bsw.vehicle.model.RepairVO;

@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	RepairMapper repairMapper;

	@Override
	public List<String> menu() throws Exception {
		List<String> menu = new ArrayList<>();
		menu.add("홈");
		menu.add("공지사항");
		menu.add("소개");
		menu.add("자유게시판");
		return menu;
	}

	@Override
	public RepairVO[] item() throws Exception {
	    List<RepairVO> resultList = repairMapper.selectItems(); // 매퍼를 통해 select 문 실행

	    return resultList.toArray(new RepairVO[0]); // 리스트를 배열로 변환하여 반환
	}

	@Override
	public RepairVO[] search(String keyword) throws Exception {
		
		RepairVO[] resultSearchList = repairMapper.searchItems(keyword);
		
		System.out.println("result length --> " + resultSearchList.length);
		
		return resultSearchList;
	}

}
