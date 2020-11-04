package com.kh.spring.myPage.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.vo.Mypage;
import com.kh.spring.myPage.model.vo.StorageBox;


@Repository("myDao")
public class MypageDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	public Mypage selectMemInfo(int mNo) {
		return sqlSession.selectOne("mypageMapper.selectMemInfo", mNo);
	}

	public Mypage selectFollowInfo(int mNo) {
		return sqlSession.selectOne("mypageMapper.selectFollowInfo", mNo);
	}

	public ArrayList<Feed> selectFeedInfo(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectFeedInfo", mNo);
	}

	public ArrayList<StorageBox> selectStorageBoxInfo(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectStorageBoxInfo", mNo);
	}

	public int insertBox(int mNo) {
		return sqlSession.insert("mypageMapper.insertBox",mNo);
	}

	public ArrayList<Mypage> selectGroupInfo(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectGroupInfo", mNo);
	}

	public String selectFollowYN(Follow fw) {
		return sqlSession.selectOne("mypageMapper.selectFollowYN", fw);
	}

	public int insertFollow(Follow fw) {
		return sqlSession.insert("mypageMapper.insertFollow",fw);
	}

	public int deleteFollow(Follow fw) {
		return sqlSession.delete("mypageMapper.deleteFollow",fw);
	}

<<<<<<< HEAD
	public ArrayList<Mypage> selectFollowerList(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectFollowerList", mNo);
	}

	public ArrayList<Mypage> selectFollowingList(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectFollowingList", mNo);
	}

=======
>>>>>>> branch 'master' of https://github.com/unimik/finalGroobee.git
	public int updateBox(ArrayList<StorageBox> sblist) {
		return sqlSession.update("mypageMapper.updateBox",sblist);
	}

	public int deleteBox(StorageBox sb) {
		return sqlSession.delete("mypageMapper.deleteBox", sb);
	}
	
}
