package com.bsw.vehicle.promotion.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bsw.vehicl.model.Promotion;
import com.bsw.vehicle.promotion.service.PromotionService;

@Controller
public class PromotionController {
  
  @Autowired
  private PromotionService promotionService;

  @RequestMapping("/vehicle/promotion.ex")
  public String promotion(Model model) throws Exception {
	 int showCount = 9;	// 한 페이지당 보여질 갯수    
	 int totalCount = 100; // 전체 홍보글 100개 (임의로 설정)
	 
	 List<Integer> pageNumbers = new ArrayList<>();
	 
     for (int i = 1; i <= totalCount/showCount + 1; i++) {
       pageNumbers.add(i);
     }
     
     model.addAttribute("pageNumbers", pageNumbers);
   
	 return "/navMenu/promotion"; 
  }
  
  @GetMapping("/vehicle/promotion/paging.ex")
  public ResponseEntity<String> promotionPage(@RequestParam("page") int pageNumber, Model model) {
    System.out.println("page --> " + pageNumber);

    // 성공 시 응답 데이터를 JSON 형태로 반환
    return ResponseEntity.ok().body("성공");
  }
}
