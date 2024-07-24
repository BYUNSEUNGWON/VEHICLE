package com.bsw.vehicle.transaction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TransactionController {
	
	@RequestMapping("/vehicle/transaction.ex")
	public String transaction(Model model) throws Exception {
		    
		 return "/navMenu/transaction"; 
	}
}
