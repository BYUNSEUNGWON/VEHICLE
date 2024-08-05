package com.bsw.vehicle.common.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bsw.vehicle.common.service.CommonService;
import com.bsw.vehicle.model.RepairVO;

import jakarta.validation.constraints.AssertFalse.List;

@Controller
public class CommonController {
	
	@Autowired
	private CommonService commonService;
	

	@RequestMapping("/vehicle/index.ex")
	public String index(Model model) throws Exception {
		
	    model.addAttribute("menu", commonService.menu());
	    
		 return "/common/index"; 
	}
	
	@PostMapping("/vehicle/item.ex")
	public ResponseEntity<RepairVO[]> allItme(Model model) throws Exception {
	
	    RepairVO repair[] = commonService.item();
	    
	    return ResponseEntity.ok().body(repair);
	    
	}
	
	@GetMapping("/vehicle/itemSel.ex")
	public ResponseEntity<RepairVO[]> selItme(@RequestParam("title") String title) throws Exception {
		System.out.println("controller start ==> "+ title);
	    RepairVO repair[] = commonService.selitem(title);
	    
	    return ResponseEntity.ok().body(repair);
	    
	}
	
	@GetMapping("/vehicle/search.ex")
	public ResponseEntity<RepairVO[]> search(@RequestParam("keyword") String keyword) throws Exception {

		RepairVO searchResults[] = commonService.search(keyword);
		
	    if (StringUtils.isEmpty(keyword)) {
	        RepairVO[] emptyResults = {}; // 빈 검색 결과 생성
	        
	        return ResponseEntity.ok().body(emptyResults);
	    }
		
	    return ResponseEntity.ok().body(searchResults);
	}
}
