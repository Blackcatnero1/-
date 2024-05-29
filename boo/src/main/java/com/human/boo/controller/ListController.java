package com.human.boo.controller;

import java.util.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

import com.human.boo.dao.*;
import com.human.boo.vo.*;

/**
 * 이 클래스는 조회한 리스트를 띄우고 페이징 처리를 위한 클래스
 * @author	이서준, 김한민
 * @version v.2.9
 * 	클래스 제작 [ 담당자 : 이서준, 김한민 ]
 */

@Controller
@RequestMapping("/list")
public class ListController {

	
	@Autowired
	ChatbotDao cbDao;
	
	//아파트 목록 조회 요청
	@RequestMapping("/list.boo") 
	public ModelAndView selList(HttpSession session, ModelAndView mv, RedirectView rv, ChatbotVO cbVO) {
		
		//select 태그에 담을 옵션 리스트에 담고
		List list = cbDao.getDongList(cbVO);
		List list2 = cbDao.getGradeList();
		mv.addObject("DongLIST",list);
		mv.addObject("GradeLIST", list2);
			
		//초기 페이지 셋팅
		int nowPage = cbVO.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		
		
		//select 태그 선택을 완료 했을때
		if(cbVO.getBjdong_nm() != null) {
			// 조회된 데이터의 총 개수
			int totalCnt = cbDao.getTotal(cbVO);
			//페이지 셋팅
			cbVO.setPage(nowPage, totalCnt);
			//아파트 리스트 담고
			List list3 = cbDao.getAptList(cbVO);
			mv.addObject("AptLIST",list3);
			
		}

		//그 외 필요한 데이터 셋팅
		mv.addObject("DATA", cbVO);
		mv.setViewName("list");
		return mv;
	}

}
