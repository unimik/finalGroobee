package com.kh.spring.notification.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.notification.model.dao.NotificationDao;
import com.kh.spring.notification.model.vo.Notification;
import com.kh.spring.pushAlarm.model.vo.PushAlarm;
@Service("nService")
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	NotificationDao nDao;
	
	@Override
	public List<Notification> getNotification(int mNo) {
		return nDao.getNotification(mNo);
	}

	@Override
	public int insertAlarm(PushAlarm pa) {
		return nDao.insertAlarm(pa);
	}

	@Override
	public ArrayList<PushAlarm> selectAlarmList(String name) {
		return nDao.selectAlarmList(name);
	}

	@Override
	public int readAlarm(PushAlarm pa) {
		return nDao.readAlarm(pa);
	}

	@Override
	public String selectGM(String crno) {
		return nDao.selectGM(crno);
	}

	@Override
	public ArrayList<Member> selectImg(String name) {
		return nDao.selectImg(name);
	}

}
