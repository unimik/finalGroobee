package com.kh.spring.declaration.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.declaration.model.dao.DeclarationDao;
import com.kh.spring.declaration.model.vo.Declaration;
@Service("dService")
public class DeclarationServiceImpl implements DeclarationService {

	@Autowired
	DeclarationDao dDao;
	
	@Override
	public int insertReport(Declaration d) {
		return dDao.insertReport(d);
	}

}
