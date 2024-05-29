package com.human.boo.dao;

import java.util.*;
import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import com.human.boo.vo.*;

public class MapDao {

	@Autowired
	SqlSessionTemplate session;
	
	public List<ChatbotVO> getInfo() {
		return session.selectList("mSQL.getInfo");
	}
	
}
