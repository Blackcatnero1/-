package com.human.boo.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.human.boo.vo.ChatbotVO;

@Controller
public class MainController {
	
	@RequestMapping("/main.boo")
	public String main() {
		return "main";
	}

    @PostMapping("/setSession.boo")
    public String setSession(@RequestBody ChatbotVO cbVO, HttpSession session) {
        session.setAttribute("nickname", cbVO.getNickname());
        return "/main";
    }
    
    @RequestMapping("/rmSession.boo")
    public String rmSession(HttpSession session) {
        session.removeAttribute("nickname");
        return "redirect:/main.boo";
    }

	@RequestMapping("/chart.boo")
	public String goChart() {
		return "yearadd";
	}
	
}
