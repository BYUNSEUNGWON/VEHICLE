package com.bsw.vehicle.transaction.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bsw.vehicle.transaction.service.TransactionService;

@Controller
public class TransactionController {

	  @Autowired
	  private TransactionService transactionService;

	  @RequestMapping("/vehicle/transaction.ex")
	  public String transaction(Model model) throws Exception {
		 int showCount = 9;	// 한 페이지당 보여질 갯수    
		 int totalCount = 100; // 전체 상품글 100개 (임의로 설정)
		 
		 List<Integer> pageNumbers = new ArrayList<>();
		 
	     for (int i = 1; i <= totalCount/showCount + 1; i++) {
	       pageNumbers.add(i);
	     }
	     
	     String girdItem = "\r\n"
	     		+ "    <div class=\"grid-item\">상품 1</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 2</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 3</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 4</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 5</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 6</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 7</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 8</div>\r\n"
	     		+ "    <div class=\"grid-item\">상품 9</div>";

	     model.addAttribute("pageNumbers", pageNumbers);
	     model.addAttribute("girdItem", girdItem);
	     
		 return "/navMenu/transaction"; 
	  }
	  
	  @PostMapping("/vehicle/transaction/paging.ex")
	  public ResponseEntity<String> transactionPage(@RequestParam("page") int pageNumber, Model model) {
	    System.out.println("page --> " + pageNumber);

	    // 성공 시 응답 데이터를 JSON 형태로 반환
	    return ResponseEntity.ok().body("성공");
	  }
}
