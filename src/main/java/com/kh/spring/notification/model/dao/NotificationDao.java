package com.kh.spring.notification.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.notification.model.vo.Notification;


@Repository("nDao")
public class NotificationDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	public List<Notification> getNotification(int mNo) {
		return sqlSession.selectList("NotificationMapper.getNotification",mNo);
	}

}
