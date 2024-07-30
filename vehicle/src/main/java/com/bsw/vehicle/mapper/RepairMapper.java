package com.bsw.vehicle.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bsw.vehicle.model.RepairVO;

@Mapper
public interface RepairMapper {
	
	    List<RepairVO> selectItems() throws Exception;
	
}
