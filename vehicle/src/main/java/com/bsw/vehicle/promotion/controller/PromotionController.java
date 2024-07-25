package com.bsw.vehicle.promotion.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class PromotionController {
	
	@RequestMapping("/vehicle/promotion.ex")
	  public String promotion(Model model) throws Exception {
		int showCount = 10;	// 한 페이지당 보여질 갯수    
		 int totalCount = 60; // 전체 홍보글 100개 (임의로 설정)
		 
		 List<Integer> pageNumbers = new ArrayList<>();
		 
	     for (int i = 1; i <= totalCount/showCount + 1; i++) {
	       pageNumbers.add(i);
	     }
	     String gridItem = "\r\n" 
	    		+ "		<div class=\"grid-item\">\r\n"
	     		+ "			<div class=\"grid-detail\">홍보글1</div>\r\n"
	     		+ "		</div>\r\n"
	     		+ "		<div class=\"grid-item\">\r\n"
	     		+ "			<div class=\"grid-detail\">홍보글2</div>\r\n"
	     		+ "		</div>\r\n"
	     		+ "		<div class=\"grid-item\">\r\n"
	     		+ "			<div class=\"grid-detail\">홍보글3</div>\r\n"
	     		+ "		</div>\r\n"
	     		+ "		<div class=\"grid-item\">\r\n"
	     		+ "			<div class=\"grid-detail\">홍보글4</div>\r\n"
	     		+ "		</div>";
	     
	     model.addAttribute("pageNumbers", pageNumbers);
	     model.addAttribute("gridItem", gridItem);
	     
		return "/navMenu/promotion";
		
	}
	

    @PostMapping("/vehicle/promotion/paging.ex")
	  public ResponseEntity<String> promotionPage(@RequestParam("page") int pageNumber, Model model) {
	    System.out.println("page --> " + pageNumber);

	    // 성공 시 응답 데이터를 JSON 형태로 반환
	    return ResponseEntity.ok().body("성공");
	  }
    
    @RequestMapping("/vehicle/promotion/write.ex")
	  public String write(Model model) {
    	
    	System.out.println("홍보하기에 글 쓰기");
    	
    	return "/promotion/write";
	  }
    
    @PostMapping("/vehicle/promotion/submit.ex")
	public ResponseEntity<String> submit(@RequestParam("body") String body, @RequestParam("style") String style, Model model) {
		System.out.println("submit.ex 까지 들어옴");
		System.out.println("Body Content: " + body);
        System.out.println("Style Content: " + style);
        
        int count = 1; // service 붙여주고 성공 시 1일 경우 제외 나머지 다 실패
        
        if(count == 1) {
        	return ResponseEntity.ok().body("성공");	
        } else {
        	return ResponseEntity.ok().body("실패");
        }
        
	    	
	}
    
}
