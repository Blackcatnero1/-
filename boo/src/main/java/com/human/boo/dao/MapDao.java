package com.human.boo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.boo.vo.*;

public class MapDao {


	@Autowired
	SqlSessionTemplate session;
	
	
	public List<ChatbotVO> getInfo() {
		return session.selectList("mSQL.getInfo");
	}
	

	

}
