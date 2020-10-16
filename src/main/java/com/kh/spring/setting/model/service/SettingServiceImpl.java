package com.kh.spring.setting.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.setting.model.dao.SettingDao;
import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;


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

}
