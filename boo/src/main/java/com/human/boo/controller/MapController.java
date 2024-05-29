package com.human.boo.controller;


import java.util.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import com.human.boo.dao.*;
import com.human.boo.vo.*;

/**
 * 이 클래스는 카카오지도 api 관련 뷰를 처리하기 위한 클래스
 * @author	이서준
 * @version v.2.9
 * 	클래스 제작 [ 담당자 : 이서준 ]
 */

@RequestMapping("/map")
@Controller
public class MapController {

	@Autowired
	MapDao mDao;

	// 매물 상세 맵으로 가는 요청 
	@RequestMapping("/map.boo")
	public ModelAndView goMap(HttpSession session, ModelAndView mv,ChatbotVO cbVO) {
		
		mv.addObject("DATA",cbVO);
		mv.setViewName("map/map");
		
		return mv;
	}

	
	// 서울시 전체적인 데이터 맵
	@RequestMapping("/datamap.boo")
	public ModelAndView goDataMap(HttpSession session, ModelAndView mv) {
		
		// 각 자치구 별로 필요한 데이터 담기
		List list1 = mDao.getInfo();
		mv.addObject("AreaDATA",list1);
		mv.setViewName("map/dataMap");
		
		return mv;
	}
}
