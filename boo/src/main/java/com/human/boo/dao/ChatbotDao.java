package com.human.boo.dao;

import java.util.List;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import com.human.boo.vo.*;

public class ChatbotDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<ChatbotVO> getAptList(ChatbotVO cbVO){
		return session.selectList("cbSQL.getAptList",cbVO);
	}
	
	public int getTotal(ChatbotVO cbVO) {
		return session.selectOne("cbSQL.selTotal",cbVO);
	}
	
	
	public List<ChatbotVO> getDongList(ChatbotVO cbVO){
		return session.selectList("cbSQL.getDongList", cbVO);
	}
	
	public List<ChatbotVO> getGradeList(){
		return session.selectList("cbSQL.getGradeList");
	}

}
