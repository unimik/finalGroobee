package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.dao.FeedDao;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.LikeIt;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.feed.model.vo.ShareFeed;
import com.kh.spring.feed.model.vo.Tag;
import com.kh.spring.group.model.vo.GroupName;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.vo.StorageBox;

@Service("fService")
public class FeedServiceImpl implements FeedService {

	@Autowired
	private FeedDao fDao;
	
	@Override
	public int insertPost(Feed f) {
		return fDao.insertPost(f);
	}
	
	@Override
	public int insertPhoto(Photo p) {
		return fDao.insertPhoto(p);
	}

	@Override
	public ArrayList<Feed> selectFeed(String userId) {
		return fDao.selectFeed(userId);
	}

	@Override
	public ArrayList<GroupName> selectGroupMemberId(String userId) {
		return fDao.selectGroupMemberId(userId);
	}
	
	@Override
	public Feed selectUpdateFeed(int fNo) {
		return fDao.selectUpdateFeed(fNo);
	}
	
	@Override
	public ArrayList<Feed> selectGfList(String userId) {
		return fDao.selectGfList(userId);
	}

	public int deletePost(int fNo) {
		return fDao.deletePost(fNo);
	}

	@Override
	public int updatePost(Feed f) {
		return fDao.updatePost(f);
	}
	
	@Override
	public ArrayList<Feed> selectGfeed(int gNo) {
		return fDao.selectGfeed(gNo);
	}

	@Override
	public ArrayList<Feed> selectHGfeed(int gNo) {
		return fDao.selectHGfeed(gNo);
	}

	/*
	 * @Override public int updatePhoto(Photo p) { return fDao.updatePhoto(p); }
	 */

	@Override
	public int insertReply(Reply r) {
		return fDao.insertReply(r);
	}

	@Override
	public Feed popFeed(int fno) {
		return fDao.popFeed(fno);
	}

	@Override
	public int insertLike(LikeIt lI) {
		return fDao.insertLike(lI);
	}

	@Override
	public int likeUp(String fNo) {
		return fDao.likeUp(fNo);
	}

	@Override
	public int likeDown(String fNo) {
		return fDao.likeDown(fNo);
	}

	@Override
	public int selectlike(LikeIt like) {
		return fDao.selectlike(like);
	}

	@Override
	public int deleteLike(LikeIt like) {
		return fDao.deleteLike(like);
	}

	

	public int updateReply(Reply r) {
		return fDao.updateReply(r);
	}

	@Override
	public int insertTag(ArrayList<Tag> taglist) {
		return fDao.insertTag(taglist);
	}

	@Override
	public int selectTag(int fNo) {
		return fDao.selectTag(fNo);
	}

	@Override
	public int deleteTag(int fNo) {
		return fDao.deleteTag(fNo);
	}

	@Override
	public int insertShare(ShareFeed sf) {
		return fDao.insertShare(sf);
	}

	@Override
	public int deleteReply(int rNo) {
		return fDao.deleteReply(rNo);
	}

	@Override
	public int insertStorage(StorageBox sb) {
		return fDao.insertStorage(sb);
	}

	@Override
	public Member findTagMember(String string) {
		return fDao.findTagMember(string);
	}

	@Override
	public ArrayList<Photo> selectPhotoList(int getfNo) {
		return fDao.selectPhotoList(getfNo);
	}

	@Override
	public int deleteFile(String fileName) {
		return fDao.deleteFile(fileName);
	}

	@Override
	public int updateDeleteTag(ArrayList<Tag> taglist) {
		return fDao.updateDeleteTag(taglist);
	}


}