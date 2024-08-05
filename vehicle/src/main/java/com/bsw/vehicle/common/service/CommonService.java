package com.bsw.vehicle.common.service;

import java.util.List;

import com.bsw.vehicle.model.RepairVO;

public interface CommonService {
	
	List<String>menu() throws Exception;

	RepairVO[] item() throws Exception;

	RepairVO[] search(String keyword) throws Exception;

	RepairVO[] selitem(String title);
	
	
}
