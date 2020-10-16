package com.kh.spring.setting.model.service;

import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;

public interface SettingService {

	NotificationSetting notificationSetting(int mNo);

	PersonalSetting personalSetting(int mNo);

}
