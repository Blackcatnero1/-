package com.human.boo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.boo.dao.ChatbotDao;
import com.human.boo.util.PageUtil;
import com.human.boo.vo.ChatbotVO;


@Controller
@RequestMapping("/list")
public class ListController {

	@Autowired
	ChatbotDao cbDao;
	
	@RequestMapping("/list.boo") 
	public ModelAndView getList(HttpSession session, ModelAndView mv, RedirectView rv, PageUtil page,ChatbotVO cbVO) {

		cbVO.setSgg_nm("강남구");
		List list = cbDao.getDongList(cbVO);
		List list2 = cbDao.getGradeList();
		mv.addObject("DongLIST",list);
		mv.addObject("GradeLIST", list2);
		mv.setViewName("list");
		return mv;
		
	}
}
