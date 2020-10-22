package com.kh.spring.declaration.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.declaration.model.vo.Declaration;

@Repository("dDao")
public class DeclarationDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int insertReport(Declaration d) {
		return sqlSession.insert("declarationMapper.insertReport",d);
	}

}
