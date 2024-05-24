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
		
		
		int nowPage = page.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		int totalCnt = cbDao.getTotal();
		page.setPage(nowPage, totalCnt);
		
		List list = cbDao.getDongList(cbVO);
		List list2 = cbDao.getGradeList();
		List list3 = cbDao.getAptList(page);
		mv.addObject("DongLIST",list);
		mv.addObject("GradeLIST", list2);
		mv.addObject("AptLIST",list3);
		mv.addObject("PAGE", page);
		mv.setViewName("list");
		return mv;
		
		
	}
}
