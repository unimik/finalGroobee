package com.kh.spring.notification.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.notification.model.dao.NotificationDao;
import com.kh.spring.notification.model.vo.Notification;
@Service("nService")
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	NotificationDao nDao;
	
	@Override
	public List<Notification> getNotification(int mNo) {
		return nDao.getNotification(mNo);
	}

}
