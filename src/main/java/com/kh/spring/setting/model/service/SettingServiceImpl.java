package com.kh.spring.setting.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.setting.model.dao.SettingDao;
import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;
import com.kh.spring.setting.model.vo.Question;


@Service("sService")
public class SettingServiceImpl implements SettingService {

	@Autowired
	SettingDao sDao;
	
	@Override
	public NotificationSetting notificationSetting(int mNo) {
		return sDao.notificationSetting(mNo);
	}

	@Override
	public PersonalSetting personalSetting(int mNo) {
		return sDao.personalSetting(mNo);
	}

	@Override
	public int updateSetting(NotificationSetting ns) {
		return sDao.updateSetting(ns);
		
		
	}

	@Override
	public int updateSetting(PersonalSetting ps) {
		System.out.println("settingService 실행확인");
		
		return sDao.updateSetting(ps);
	}

	@Override
	public int insertQuestion(Question q) {
		return sDao.insertQuestion(q);
	}

	@Override
	public int insertNSetting(int mNo) {
		return sDao.insertNSetting(mNo);
	}

	@Override
	public int insertPSetting(int mNo) {
		return sDao.insertPSetting(mNo);
	}

	@Override
	public int disableblock(PersonalSetting p) {
		return sDao.disableblock(p);
	}



}
