package com.bsw.vehicle.promotion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PromotionController {
	
	@RequestMapping("/vehicle/promotion.ex")
	public String promotion(Model model) throws Exception {
		    
		 return "/navMenu/promotion"; 
	}
}
