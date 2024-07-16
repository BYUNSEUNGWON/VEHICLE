package com.bsw.vehicle.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bsw.vehicle.common.service.CommonService;

@Controller
public class CommonController {
	
	@Autowired
	private CommonService commonService;
	

	@RequestMapping("/vehicle/index.ex")
	public String index(Model model) throws Exception {
		
	    model.addAttribute("menu", commonService.menu());
	    
		 return "/common/index"; 
	}
	

}
