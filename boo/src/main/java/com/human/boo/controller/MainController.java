package com.human.boo.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.human.boo.vo.VO;

@Controller
public class MainController {
	
	
	@RequestMapping("/main.boo")
	public String main() {
		return "main";
	}
	@RequestMapping("/main2.boo")
	public String main2() {
		return "main2";
	}
	
	@RequestMapping("/list.boo")
	public String list() {
		return "list";
	}
	
	
	
    @PostMapping("/setSession.boo")
    public String setSession(@RequestBody VO vo, HttpSession session) {
        session.setAttribute("nickname", vo.getNickname());
        return "/main2";
    }
    
    @RequestMapping("/rmSession.boo")
    public String rmSession(HttpSession session) {
        session.removeAttribute("nickname");
        return "redirect:/main2.boo";
    }

	

	
	
	
	
}
