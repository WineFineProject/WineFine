package com.sist.service;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.*;
import com.sist.vo.*;
@Service
public class ReplyBoardServiceImpl implements ReplyBoardService{
	@Autowired
	private ReplyDAO dao;

	@Override
	public List<ReplyBoardVO> replyListData(int start, int end, String userid) {
		// TODO Auto-generated method stub
	    return dao.replyListData(start, end, userid);
	}

	@Override
	public int replyCount() {
		// TODO Auto-generated method stub
		return dao.replyCount();
	}

	@Override
	public void replyInsert(ReplyBoardVO vo) {
		// TODO Auto-generated method stub
		dao.replyInsert(vo);
	}

	@Override
	public ReplyBoardVO replyDetailData(int wrno) {
		// TODO Auto-generated method stub
		return dao.replyDetailData(wrno);
	}

	@Override
	public void replyDelete(int group_id) {
		// TODO Auto-generated method stub
		dao.replyDelete(group_id);
	}

	@Override
	public void replyUpdateData(ReplyBoardVO vo) {
		// TODO Auto-generated method stub
		dao.replyUpdateData(vo);
	}
	
	@Override
	public ReplyBoardVO replyDetail(int wrno) {
		return dao.replyDetail(wrno);
	}
}
