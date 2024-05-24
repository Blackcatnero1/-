package com.human.boo.dao;

import java.util.List;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;


import com.human.boo.util.*;
import com.human.boo.vo.*;


public class ListDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public List<ListVO> getList(PageUtil page){
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		return session.selectList("lSQL.list", page);
	}
	
	public int getTotal() {
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		return session.selectOne("lSQL.listTotal");
	}
}
