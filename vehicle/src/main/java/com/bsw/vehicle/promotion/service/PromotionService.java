package com.bsw.vehicle.promotion.service;

import java.util.List;

import com.bsw.vehicl.model.Promotion;

public interface PromotionService {
	
	List<Promotion> getAllPromotions();  // 모든 홍보 데이터 조회 메서드
    
    Promotion getPromotionById(Long id);  // 특정 홍보 데이터 조회 메서드
    
    List<Promotion> getPromotionsByPage(int pageNumber, int showCount);  // 페이지에 해당하는 홍보 데이터 조회 메서드

}
