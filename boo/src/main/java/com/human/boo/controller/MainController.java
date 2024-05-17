package com.human.boo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class MainController {
	
	@RequestMapping("/main.boo")
	public String getMain() {
		return "main";
	}
}
