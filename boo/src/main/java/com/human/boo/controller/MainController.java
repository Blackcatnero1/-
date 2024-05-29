package com.human.boo.controller;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import com.human.boo.vo.*;

/**
 * 이 클래스는 메인 페이지 요청 및 로그인 기능을 처리하기 위한 클래스
 * @author	이서준
 * @version v.2.9
 * 	클래스 제작 [ 담당자 : 이서준 ]
 */


@Controller
public class MainController {
	
	//메인페이지으로 가는 요청
	@RequestMapping("/main.boo")
	public String main() {
		return "main";
	}

	//메인페이지에 닉네임을 세션에 등록
    @PostMapping("/setSession.boo")
    public String setSession(@RequestBody ChatbotVO cbVO, HttpSession session) {
        session.setAttribute("nickname", cbVO.getNickname());
        return "/main";
    }
	//메인페이지에 닉네임을 세션에서 삭제    
    @RequestMapping("/rmSession.boo")
    public String rmSession(HttpSession session) {
        session.removeAttribute("nickname");
        return "redirect:/main.boo";
    }

    //차트를 보여주는 요청
	@RequestMapping("/chart.boo")
	public String goChart() {
		return "yearadd";
	}
	
}
