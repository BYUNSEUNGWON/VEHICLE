package com.bsw.vehicle.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bsw.vehicle.model.AttachVO;
import com.bsw.vehicle.model.PromotionVO;
import com.bsw.vehicle.model.RepairVO;

@Mapper
public interface PromotionMapper {

		int insertContents(PromotionVO promotino);

		void insertFile(AttachVO attach);

		int countProIdx();

		PromotionVO getProItem(int i);

		String getImgUrl(@Param("i") int i);

	    PromotionVO getDetail(@Param("promotion_id") String promotion_id, @Param("title") String title);


}
