package com.bsw.vehicle.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LoginMapper {

	int checkUserId(@Param("userId")String userId);

}
