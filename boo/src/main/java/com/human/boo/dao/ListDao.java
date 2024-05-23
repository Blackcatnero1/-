package com.human.boo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.human.boo.util.PageUtil;
import com.human.boo.vo.ListVO;

@Repository
public class ListDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public List<ListVO> getList(PageUtil page){
		return session.selectList("lSQL.selList", page);
	}
	
	public int getTotal() {
		return session.selectOne("fSQL.selTotal");
	}
}
