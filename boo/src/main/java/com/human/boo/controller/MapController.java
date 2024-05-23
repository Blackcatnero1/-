package com.human.boo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;



@RequestMapping("/map")
@Controller
public class MapController {

	
	@RequestMapping("/map.boo")
	public String goMap() {
		
		return "map/map";
	}

	
	@RequestMapping("/datamap.boo")
	public String gosubMap() {
		
		return "map/dataMap";
	}
}
