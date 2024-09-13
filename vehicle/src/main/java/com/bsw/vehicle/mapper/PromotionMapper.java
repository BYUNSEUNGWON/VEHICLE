package com.bsw.vehicle.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bsw.vehicle.model.AttachVO;
import com.bsw.vehicle.model.CommentVO;
import com.bsw.vehicle.model.PromotionVO;
import com.bsw.vehicle.model.RepairVO;
import com.bsw.vehicle.model.UserVO;

@Mapper
public interface PromotionMapper {

		int insertContents(PromotionVO promotino);

		void insertFile(AttachVO attach);

		int countProIdx();

		PromotionVO getProItem(int i);

		String getImgUrl(@Param("i") int i);

	    PromotionVO getDetail(@Param("promotion_id") String promotion_id, @Param("title") String title);

		List<CommentVO> getComment(String promotion_id);

		int getCommCount(String promotion_id);

		void updtClick(String promotion_id);

		int insertComment(@Param("comment") String comment, @Param("promotion_id") String promotion_id, @Param("promotion_seq") int promotion_seq, @Param("regist_user_id") String regist_user_id);

		List<PromotionVO> serachItem(@Param("param") String param);

		UserVO getUserInfo(@Param("userId") String userId);



}
