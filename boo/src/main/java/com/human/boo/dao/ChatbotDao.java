package com.human.boo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.boo.vo.ChatbotVO;
import com.human.boo.vo.GradeVO;

public class ChatbotDao {


	@Autowired
	SqlSessionTemplate session;
	
	
	
	public List<ChatbotVO> getDongList(ChatbotVO cbVO){
		return session.selectList("cbSQL.getDongList", cbVO);
	}
	
	public List<GradeVO> getGradeList(){
		return session.selectList("cbSQL.getGradeList");
	}

}
