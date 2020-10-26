package com.kh.spring.admin.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.admin.dao.AdminDao;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;

@Service("aService")
public class AdminServiceImpl implements AdminService{

	@Autowired
	AdminDao aDao;

	@Override
	public ArrayList<Member> memberSearchList(Member m) {
		return aDao.memberSearchList(m);
	}

	@Override
	public ArrayList<Group> groupSearchList(Group g) {
		return aDao.groupSearchList(g);
	}
}
