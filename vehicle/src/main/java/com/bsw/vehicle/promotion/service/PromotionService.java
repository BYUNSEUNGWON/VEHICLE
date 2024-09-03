package com.bsw.vehicle.promotion.service;


import org.springframework.web.multipart.MultipartFile;

import com.bsw.vehicle.model.PromotionVO;

public interface PromotionService {

	int insertContensts(PromotionVO promotino);
	
	String uploadAttach(MultipartFile uploadedFile, String fileId, String ext, String registUserId);

	int countProIdx();

	PromotionVO getProItem(int i);

	StringBuilder getContents(StringBuilder gridItemsBuilder, PromotionVO promotion, int i);

	PromotionVO showDetail(String promotion_id, String title);

	

}
