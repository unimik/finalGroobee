package com.kh.spring.notification.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.notification.model.vo.Notification;
import com.kh.spring.pushAlarm.model.vo.PushAlarm;


@Repository("nDao")
public class NotificationDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	public List<Notification> getNotification(int mNo) {
		return sqlSession.selectList("NotificationMapper.getNotification",mNo);
	}

	public int insertAlarm(PushAlarm pa) {
		return sqlSession.insert("NotificationMapper.insertAlarm",pa);
	}

	public ArrayList<PushAlarm> selectAlarmList(String name) {
		return (ArrayList)sqlSession.selectList("NotificationMapper.selectAlarmList",name);
	}

	public int readAlarm(PushAlarm pa) {
		return sqlSession.update("NotificationMapper.readAlarm",pa);
	}

	public String selectGM(String crno) {
		return sqlSession.selectOne("groupMapper.selectGm",crno);
	}

	public ArrayList<Member> selectImg(String name) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectImg",name);
	}

}
