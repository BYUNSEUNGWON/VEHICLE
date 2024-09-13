package com.bsw.vehicle.promotion.service;


import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.bsw.vehicle.model.CommentVO;
import com.bsw.vehicle.model.PromotionVO;

public interface PromotionService {

	int insertContensts(PromotionVO promotino);
	
	String uploadAttach(MultipartFile uploadedFile, String fileId, String ext, String registUserId);

	int countProIdx();

	PromotionVO getProItem(int i);

	StringBuilder getContents(StringBuilder gridItemsBuilder, PromotionVO promotion, int i);

	PromotionVO showDetail(String promotion_id, String title);

	List<CommentVO> showComment(String promotion_id);

	void updtClick(String promotion_id);

	String insertComment(String comment, String promotion_id, String regist_user_id);

	List<PromotionVO> serachItem(String param);

	

}
