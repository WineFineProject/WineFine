package com.sist.dao;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.*;
@Repository
public class ReplyDAO {
	@Autowired
	private ReplyBoardMapper mapper;
	
	public List<ReplyBoardVO> replyListData(int start, int end, String userid)
	{
		return mapper.replyListData(start, end, userid);
	}
	public int replyCount()
	{
		return mapper.replyCount();
	}
	public void replyInsert(ReplyBoardVO vo)
	{
		mapper.replyInsert(vo);
	}
	public ReplyBoardVO replyDetailData(int wrno)
	{
		mapper.hitIncrement(wrno);
		return mapper.replyDetailData(wrno);
	}
	public ReplyBoardVO replyDetail(int wrno)
	{
		return mapper.replyDetailData(wrno);
	}
	public void replyDelete(int group_id)
	{
		mapper.replyDelete(group_id);
	}
	public void replyUpdateData(ReplyBoardVO vo)
	{
		mapper.replyUpdateData(vo);
	}

}
