package com.kh.spring.setting.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;

@Repository("sDao")
public class SettingDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	

	public NotificationSetting notificationSetting(int mNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("settingMapper.nSetting",mNo);
	}

	public PersonalSetting personalSetting(int mNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("settingMapper.pSetting",mNo);
	}

}
