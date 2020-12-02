package com.kh.spring.setting.model.service;

import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;
import com.kh.spring.setting.model.vo.Question;

public interface SettingService {

	NotificationSetting notificationSetting(int mNo);

	PersonalSetting personalSetting(int mNo);

	int updateSetting(NotificationSetting ns);

	int updateSetting(PersonalSetting ps);

	int insertQuestion(Question q);

	int insertNSetting(int mNo);

	int insertPSetting(int mNo);

	int disableblock(PersonalSetting p);

	NotificationSetting notifyset(String mNo);





}
