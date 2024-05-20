package com.human.boo.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class loginController {

	@RequestMapping("/login.boo")
	public String getMain() {
		return "login";
	}
}
