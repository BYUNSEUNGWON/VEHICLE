package com.bsw.vehicle.notice.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bsw.vehicl.model.Notice;

@Controller
public class NoticeController {
	
	@RequestMapping("/vehicle/notice.ex")
	public String notice(Model model) throws Exception {
		List<Notice> listNotice = new ArrayList<>(); // Assuming you have a Notice class
		
		Notice notice1 = new Notice(1, "Important Notice", "2021-09-30", "admin");
		Notice notice2 = new Notice(2, "Upcoming Events", "2021-10-05", "admin");
		Notice notice3 = new Notice(3, "Maintenance Schedule", "2021-10-10", "admin");
		listNotice.add(notice1);
		listNotice.add(notice2);
		listNotice.add(notice3);
		
		 int showCount = 10;	// 한 페이지당 보여질 갯수    
		 int totalCount = 60; // 전체 홍보글 100개 (임의로 설정)
		 
		 List<Integer> pageNumbers = new ArrayList<>();
		 
	     for (int i = 1; i <= totalCount/showCount + 1; i++) {
	       pageNumbers.add(i);
	     }

	    model.addAttribute("pageNumbers", pageNumbers);
		model.addAttribute("listNotice", listNotice);
		return "/navMenu/notice"; 
	}
	
	@PostMapping("/vehicle/notice/paging.ex")
	  public ResponseEntity<List<Notice>> noticePage(@RequestParam("page") int pageNumber, Model model) {
	    System.out.println("page --> " + pageNumber);
		List<Notice> listNotice = new ArrayList<>(); // Assuming you have a Notice class
				
		Notice notice1 = new Notice(1, "Important Notice123123", "2021-09-30", "admin1");
		Notice notice2 = new Notice(2, "Upcoming Events123123", "2021-10-015", "admin2");
		Notice notice3 = new Notice(3, "Maintenance Schedule12312", "2021-10-101", "admin3");
		listNotice.add(notice1);
		listNotice.add(notice2);
		listNotice.add(notice3);
		
		model.addAttribute("listNotice", listNotice);
		
	    return ResponseEntity.ok().body(listNotice);
	  }
}
