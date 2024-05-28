package com.human.boo.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.human.boo.dao.MapDao;
import com.human.boo.vo.ChatbotVO;


@RequestMapping("/map")
@Controller
public class MapController {

	@Autowired
	MapDao mDao;

	@RequestMapping("/map.boo")
	public ModelAndView goMap(HttpSession session, ModelAndView mv,ChatbotVO cbVO) {
		mv.addObject("DATA",cbVO);
		mv.setViewName("map/map");
		
		return mv;
	}

	
	@RequestMapping("/datamap.boo")
	public ModelAndView goDataMap(HttpSession session, ModelAndView mv) {
		List list1 = mDao.getInfo();
		mv.addObject("AreaDATA",list1);
		mv.setViewName("map/dataMap");
		
		return mv;
	}
}
