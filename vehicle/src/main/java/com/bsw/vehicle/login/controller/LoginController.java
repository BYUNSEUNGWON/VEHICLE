package com.bsw.vehicle.login.controller;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.bsw.vehicle.login.service.LoginService;
import com.bsw.vehicle.model.PromotionVO;


@Controller
public class LoginController {
	
	@Autowired
    private LoginService loginService;
	
    @PostMapping("/vehicle/login.ex")
    public String login(@RequestParam("userId") String userId,
                        @RequestParam("password") String password,
                        Model model) {

        boolean isValidUser = loginService.validateUser(userId, password);

        if (isValidUser) {
            // 로그인 성공 시 메인 페이지로 리디렉션
            return "redirect:/vehicle/index.ex";
        } else {
            // 로그인 실패 시 메시지와 함께 로그인 페이지로 다시 보냄
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login"; // 로그인 페이지의 이름을 반환 (예: login.jsp)
        }
    }
	
	@GetMapping("/vehicle/regist.ex")
	public String regist(Model model) {
		System.out.println("Model ==> " + model);
        return "/login/regist";
	}
	
	@PostMapping("/vehicle/login/dupCheck.ex")
	public ResponseEntity<String> promotionPage(@RequestParam("userId") String userId, Model model) {
		
		int check = loginService.checkUserId(userId);
		System.out.println("checkVal ==> " + check);
		if(check == 0) {
			return ResponseEntity.ok().body("success");
		}else {
			return ResponseEntity.ok().body("false");
		}
		 
	}
  
	
}
