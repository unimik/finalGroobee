package com.kh.spring.admin.service;

import java.util.ArrayList;

import com.kh.spring.declaration.model.vo.Declaration;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.setting.model.vo.Question;

public interface AdminService {



	/** 1-1. 회원 리스트 조회
	 * @param m
	 * @return
	 */
	ArrayList<Member> memberSearchList(Member m);

	/** 1-2. 회원 상태 변경
	 * @param member
	 * @return
	 */
	int memberStatusChange(Member m);
	
	/**1-3. 전체 회원 수 조회
	 * @return
	 */
	int totalMember();
	
	/** 2-1. 그룹 리스트 조회
	 * @param g
	 * @return
	 */
	ArrayList<Group> groupSearchList(Group g);

	/** 2-2. 그룹 상태 변경
	 * @param g
	 * @return
	 */
	int groupStatusChange(Group g);
	
	/** 2-3. 총 group 수 조회
	 * @return
	 */
	int totalGroups();
	
	/** 3-1. 댓글 리스트 조회
	 * @param re
	 * @return
	 */
	

	/** 3-2. 댓글 상태 변경
	 * @param r
	 * @return
	 */
	int replyStatusChange(Reply r);

	
	ArrayList<Reply> replySearchList(Reply re);

	/** 4-1. 피드 리스트 조회
	 * @param f
	 * @return
	 */
	ArrayList<Feed> feedSearchList(Feed f);

	/** 4-2. 피드 상태 변경
	 * @param f
	 * @return
	 */
	int feedStatusChange(Feed f);

	/** 5-1. 문의사항(모달)
	 * @return
	 */
	ArrayList<Question> questionSearchList();
	ArrayList<Member> questionSearchListName();

	/** 6-1. 신고 조회
	 * @param d
	 * @return
	 */
	ArrayList<Declaration> reportSearchList(Declaration d);

	
	/** 6-2. 신고된 그룹 상세보기
	 * @param number
	 * @return
	 */
	Group loadgroup(int number);

	/** 6-3. 지연된 신고 수
	 * @return
	 */
	int delayedReport();

	/** 6-4. 신고 처리
	 * @param dNo
	 * @return
	 */
	int declarationStatusChange(String dNo);







}
