package com.human.boo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.boo.dao.ListDao;
import com.human.boo.util.PageUtil;
import com.human.boo.vo.ListVO;

@Controller
@RequestMapping("/list")
public class ListController {
	@Autowired
	ListDao lDao;
	
	@RequestMapping("/list.son") 
	public ModelAndView slist(HttpSession session, ModelAndView mv, RedirectView rv, PageUtil page) {
		// 할일
		int nowPage = page.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		
		int totalCnt = lDao.getTotal();
		
		page.setPage(nowPage, totalCnt);
		
		// 데이터 베이스에서 조회
		List<ListVO> list = lDao.getList(page);

		
		// 데이터 전달하고
		mv.addObject("LIST", list);
		mv.addObject("PAGE", page);
		// 뷰 셋팅하고
		mv.setViewName("list/list");
		return mv;
	}
}
