package com.bsw.vehicle.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {
	
	@RequestMapping("/vehicle/notice.ex")
	public String notice(Model model) throws Exception {
		    
		 return "/navMenu/notice"; 
	}
}
