package com.kh.spring.declaration.model.service;

import com.kh.spring.declaration.model.vo.Declaration;

public interface DeclarationService {

	/** 신고 하기
	 * @param d
	 * @return
	 */
	int insertReport(Declaration d);

}
