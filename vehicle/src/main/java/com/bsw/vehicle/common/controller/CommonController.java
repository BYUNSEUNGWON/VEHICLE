package com.bsw.vehicle.common.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
