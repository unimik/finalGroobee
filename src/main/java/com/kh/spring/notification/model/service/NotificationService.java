package com.kh.spring.notification.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.notification.model.vo.Notification;
import com.kh.spring.pushAlarm.model.vo.PushAlarm;


public interface NotificationService {

	List<Notification> getNotification(int mNo);

	int insertAlarm(PushAlarm pa);

	ArrayList<PushAlarm> selectAlarmList(String name);

	int readAlarm(PushAlarm pa);

	String selectGM(String crno);

	ArrayList<Member> selectImg(String name);

}
