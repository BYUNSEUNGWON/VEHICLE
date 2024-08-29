package com.bsw.vehicle.promotion.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bsw.vehicle.mapper.PromotionMapper;
import com.bsw.vehicle.model.PromotionVO;
import com.bsw.vehicle.promotion.service.PromotionService;

@Service
public class PromotionServiceImpl implements PromotionService{
	
	@Autowired
	PromotionMapper promotionMapper;
	

	@Override
	public int insertContensts(PromotionVO promotion) {
		
	    int result = promotionMapper.insertContents(promotion);
	    
	    if (result == 1) {
	        return 1;
	    } else {
	        return 0;
	    }
	    
	}

}
