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
	
	public List<ReplyBoardVO> replyListData(int start, int end)
	{
		return mapper.replyListData(start, end);
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

}
