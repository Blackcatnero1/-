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
	
	
	
    @PostMapping("/setSession.boo")
    public String setSession(@RequestBody VO vo, HttpSession session) {
        session.setAttribute("nickname", vo.getNickname());
        return "/main2";
    }
	
	@RequestMapping("/loginProc.boo")
    public String main(HttpSession session, ModelAndView mv) {
        String nickname = (String) session.getAttribute("nickname");
        if (nickname != null) {
            mv.addObject("nickname", nickname);
            return "/main2";
        } else {
            return "redirect:/login.boo";
        }
    }
	

	
	
	
	
}
