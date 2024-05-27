package com.human.boo.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.human.boo.dao.MapDao;



@RequestMapping("/map")
@Controller
public class MapController {

	@Autowired
	MapDao mDao;

	
	@RequestMapping("/map.boo")
	public String goMap() {
		
		
		return "map/map";
	}

	
	@RequestMapping("/datamap.boo")
	public ModelAndView goDataMap(HttpSession session, ModelAndView mv) {
		
		List list1 = mDao.getInfo();
		mv.addObject("AreaDATA",list1);
		mv.setViewName("map/dataMap");
		
		return mv;
	}
}
