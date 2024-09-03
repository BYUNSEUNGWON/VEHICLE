package com.bsw.vehicle.promotion.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bsw.vehicle.model.PromotionVO;
import com.bsw.vehicle.promotion.service.PromotionService;


@Controller
public class PromotionController {
	
	@Autowired
	private PromotionService promotionService;
	
	private static final int showCount = 3;	// 페이징 당 보여질 화면 갯수
	
	@RequestMapping("/vehicle/promotion.ex")
	  public String promotion(Model model) throws Exception {
		
		 StringBuilder gridItemsBuilder = new StringBuilder();

		 int totalCount = promotionService.countProIdx();
		 
		 System.out.println("totalCount ===========> " + totalCount);
		 
		 List<Integer> pageNumbers = new ArrayList<>();
		 
	     for (int i = 1; i <= totalCount/showCount + 1; i++) {
	    	 pageNumbers.add(i);
	    	 if(i *showCount == totalCount) { // 글 갯수가 딱 맞을 경우
	    		 break;
	    	 }
	     }
	     int forCount = 0;
	     
	     if(totalCount < showCount) {
	    	 forCount = totalCount;
	     } else {
	    	 forCount = showCount;
	     }
	     
	     for (int i = 1; i <= forCount; i++) {
	    	 PromotionVO promotion = promotionService.getProItem(i);
	    	 gridItemsBuilder = promotionService.getContents(gridItemsBuilder, promotion, i);
    	}
	    
	     
	     model.addAttribute("pageNumbers", pageNumbers);
	     model.addAttribute("gridItem", gridItemsBuilder.toString());
	     
		return "/navMenu/promotion";
		
	}
	

    @PostMapping("/vehicle/promotion/paging.ex")
	  public ResponseEntity<String> promotionPage(@RequestParam("page") int pageNumber, Model model) {

		 StringBuilder gridItemsBuilder = new StringBuilder();
		 
		 int i = showCount * pageNumber - 2;
		 int target = i + showCount;
		 int totalCount = promotionService.countProIdx();
		 
		 if(target > totalCount) {
			 target = totalCount + 1;
		 }
		 
	     for(int k = i; k < target; k++) {
	    	 PromotionVO promotion = new PromotionVO();
	    	 promotion = promotionService.getProItem(k);
	    	 gridItemsBuilder = promotionService.getContents(gridItemsBuilder, promotion, k);
	     }

	    // 성공 시 응답 데이터를 JSON 형태로 반환
	    return ResponseEntity.ok().body(gridItemsBuilder.toString());
	  }
    
	@RequestMapping("/vehicle/promotion/write.ex")
	  public String write(Model model) {
    	
    	System.out.println("홍보하기에 글 쓰기");
    	
    	return "/promotion/write";
	  }
    
    @PostMapping("/vehicle/promotion/submit.ex")
	public ResponseEntity<String> submit(@RequestParam("title") String title, @RequestParam("contents") String contents, @RequestParam(value = "image", required = false) MultipartFile uploadedFile, Model model) {
		
        PromotionVO promotion = new PromotionVO();
        
        String fileResult = "";
        String fileId = "";
        String promotionId = "title-" + UUID.randomUUID().toString();

       
        promotion.setTitle(title);
        promotion.setContents(contents);
        promotion.setRegist_user_id("admin"); // 임시정책
        promotion.setPromotion_id(promotionId);
        
        if (uploadedFile != null && !uploadedFile.isEmpty()) {
        	
			 String originalFilename = uploadedFile.getOriginalFilename();
			 String extension = "";
			 String registUserId = "admin";
			 
			 int i = originalFilename.lastIndexOf('.');
			 
			 if (i > 0) {
			     extension = originalFilename.substring(i);
			 }
			
			 fileId = UUID.randomUUID().toString() + extension;

			 promotion.setFile_id(fileId);
			 fileResult = promotionService.uploadAttach(uploadedFile, fileId, extension, registUserId);
			 
			 if(!"SUCCESS".equals(fileResult)) {
				 return ResponseEntity.ok().body("실패"); 
			 }
			 
        }
        
        int count = promotionService.insertContensts(promotion); // 글 저장
        
        if(count == 1) {
        	return ResponseEntity.ok().body("성공");	
        } else {
        	return ResponseEntity.ok().body("실패");
        }
        
	    	
	}
    
    @GetMapping("/vehicle/promotion/showItem.ex")
    public String showItem(@RequestParam("title") String title, @RequestParam("promotion_id") String promotion_id, Model model) {
	  	
	  	PromotionVO promotion = new PromotionVO();
	  	promotion = promotionService.showDetail(promotion_id, title);
	  	
	  	model.addAttribute("promotion", promotion);
	  	
	  	return "/promotion/showContents";
   }
    
}
