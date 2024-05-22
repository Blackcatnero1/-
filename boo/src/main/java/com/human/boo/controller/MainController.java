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
	
	
	
	@RequestMapping("/loginProc.boo")
    public String main(HttpSession session, ModelAndView mv) {
        String nickname = (String) session.getAttribute("nickname");
        if (nickname != null) {
            mv.addObject("nickname", nickname);
            return "/main";
        } else {
            return "redirect:/login.boo";
        }
    }
	@RequestMapping("/login.boo")
	public String getLogin() {
		return "login";
	}
	
	
	
	
}
