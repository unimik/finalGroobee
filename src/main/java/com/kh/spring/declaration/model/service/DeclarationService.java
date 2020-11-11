package com.kh.spring.declaration.model.service;

import com.kh.spring.declaration.model.vo.Declaration;

public interface DeclarationService {

	/** 1. 그룹 신고
	 * @param d
	 * @return
	 */
	int insertGReport(Declaration d);

}
