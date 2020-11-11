package com.kh.spring.group.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.search.model.vo.Search;

public interface GroupService {

	/**
	 * 1. 그룹 리스트
	 * @return
	 */
	ArrayList<Group> selectList();

	/**
	 * 2. 그룹 인서트
	 * @param g
	 * @return
	 */
	int insertGroup(Group g);

	/**
	 * 3. 그룹 멤버 인서트
	 * @param g
	 * @return
	 */
	int insertGM(GroupMember gm);

	/**
	 * 4. 그룹 상세조회
	 * @param gNo
	 * @return
	 */
	Group selectGroup(int gNo);

	/**
	 * 5. 그룹 회원가입 (대기)
	 * @param gm
	 * @return
	 */
	int gmInsert(GroupMember gm);

	/**
	 * 6. 멤버 아이디 조회
	 *    이미 가입한 멤버인지 조회하기
	 * @param gm
	 * @return
	 */
	int gmSelectId(GroupMember gm);

	/**
	 * 7. 그룹 멤버 삭제
	 * @param gm
	 * @return
	 */
	int gmDelete(GroupMember gm);

	/**
	 * 8. 그룹수정
	 * @param gNo
	 * @return
	 */
	Group selectUpdateGroup(int gNo);

	/**
	 * 9. 그룹 전체멤버 조회
	 * @param gNo
	 * @return
	 */
	ArrayList<GroupMember> selectGmList(int gNo);

	/**
	 * 10. 승인안된 멤버 조회
	 * @param gNo
	 * @return
	 */
	ArrayList<GroupMember> selectNgmList(int gNo);

	/**
	 * 11. 멤버 가입 승인
	 * @param gm
	 * @return
	 */
	int gmUpdate(GroupMember gm);
	
	/**
	 * 12. 그룹정보 업데이트
	 * @param g
	 * @return
	 */
	int updateGroup(Group g);

	/**
	 * 13. 가입신청한 멤버 체크
	 * @param gm
	 * @return
	 */
	int gmCheckId(GroupMember gm);

	/**
	 * 14. 멤버 강퇴/거절하기
	 * @param gm
	 * @return
	 */
	int gmDeleteCheck(GroupMember gm);

	/**
	 * 15. 그룹 삭제
	 * @param gNo
	 * @return
	 */
	int groupDelete(int gNo);

	/**
	 * 16. 그룹장 위임
	 * @param gm
	 * @return
	 */
	int gmChangeMaster(GroupMember gm);

	/**
	 * 17. 원래 그룹장 일반멤버로 변경
	 * @param gm
	 * @return
	 */
	int gmChangeLevel(GroupMember gm);

	/**
	 * 18. 그룹장 변경 후 -> gCreator도 변경
	 * @param g
	 * @return
	 */
	int gCreatorChange(Group g);

	/**
	 * 19. 매니저 지정
	 * @param gm
	 * @return
	 */
	int gmChangeManager(GroupMember gm);

	/**
	 * 20. 그룹 매니저 변경
	 * @param g
	 * @return
	 */
	int gManagerChange(Group g);

	/**
	 * 21. 매니저 -> 멤버로 변경
	 * @param gm
	 * @return
	 */
	int gmChangeMember(GroupMember gm);

	/**
	 * 22. 그룹매니저 삭제
	 * @param g
	 * @return
	 */
	int gManagerDelete(Group g);

	Group getManagerId(String fromId);

	/**
	 * 그룹내 검색 (유저)
	 * @param s 
	 * @return
	 */
	ArrayList<Feed> groupSearch(Search s);




	
	

}
