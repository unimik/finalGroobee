package com.kh.spring.notification.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.spring.notification.model.vo.Notification;
import com.kh.spring.notification.model.vo.PushAlram;


public interface NotificationService {

	List<Notification> getNotification(int mNo);

	int insertAlram(PushAlram a);

}
