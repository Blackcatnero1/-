package com.human.boo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.boo.dao.ChatbotDao;
import com.human.boo.vo.ChatbotVO;


@Controller
@RequestMapping("/list")
public class ListController {

	@Autowired
	ChatbotDao cbDao;
	
	@RequestMapping("/list.boo") 
	public ModelAndView selList(HttpSession session, ModelAndView mv, RedirectView rv, ChatbotVO cbVO) {
		
		if(cbVO.getSgg_nm() == null) {
			// 발화 꺼내서 처리
			cbVO.setSgg_nm("강남구");
		}
		
		List list = cbDao.getDongList(cbVO);
		List list2 = cbDao.getGradeList();
		mv.addObject("DongLIST",list);
		mv.addObject("GradeLIST", list2);
			
		int nowPage = cbVO.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		int totalCnt = cbDao.getTotal(cbVO);
		cbVO.setPage(nowPage, totalCnt);
		
		
		if(cbVO.getBjdong_nm() != null) {
			List list3 = cbDao.getAptList(cbVO);
			mv.addObject("AptLIST",list3);
			
		}


		mv.addObject("DATA", cbVO);
		
		mv.setViewName("list");
		return mv;
		
	}

	
}
