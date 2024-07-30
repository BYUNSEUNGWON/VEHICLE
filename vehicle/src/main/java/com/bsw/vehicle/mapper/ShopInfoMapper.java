package com.bsw.vehicle.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopInfoMapper {
	
	void insertShop(Map map);

}
