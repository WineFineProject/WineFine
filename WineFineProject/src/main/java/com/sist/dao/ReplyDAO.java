package com.sist.dao;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.*;

@Repository
public class ReplyDAO {
	@Autowired
	private ReplyBoardMapper mapper;
	
	public List<ReplyBoardVO> shopReplyListData(int count, String userid, int wno){
		return mapper.shopReplyListData(count, userid, wno);
	}
	
	public int shopReplyTotalPage(int wno) {
		return mapper.shopReplyTotalPage(wno);
	}
	
	public List<ReplyBoardVO> replyListData(int start, int end, String userid) {
		return mapper.replyListData(start, end, userid);
	}

	public int replyCount() {
		return mapper.replyCount();
	}
	
	public int shopReplyCount() {
		return mapper.shopReplyCount();
	}

	public void replyInsert(ReplyBoardVO vo) {
		mapper.replyInsert(vo);
	}

	public ReplyBoardVO replyDetailData(int wrno) {
		mapper.hitIncrement(wrno);
		return mapper.replyDetailData(wrno);
	}

	public ReplyBoardVO replyDetail(int wrno) {
		return mapper.replyDetailData(wrno);
	}

	public void replyDelete(int group_id) {
		mapper.replyDelete(group_id);
	}

	public void replyUpdateData(ReplyBoardVO vo) {
		mapper.replyUpdateData(vo);
	}

	public int sellerReplyCount(String userid) {
		return mapper.sellerReplyCount(userid);
	}

	public List<ReplyBoardVO> sellrReplyListData(Map map) {
		return mapper.sellrReplyListData(map);
	}
	
	 public void sellerReplyInsert(ReplyBoardVO vo) {
		 mapper.replyStateUpdate(1, vo.getWrno());
		 mapper.sellerReplyInsert(vo);
	 }
	 
	 public ReplyBoardVO replyAnswerDetailData(int group_id) {
		 return mapper.replyAnswerDetailData(group_id);
	 }
   
	 public void replyAnswerDelete(int wrno) {
		 mapper.replyQuestStateUpdate(wrno);
		 mapper.replyAnswerDelete(wrno);
	 }
	 
	 public void sellerReplyUpdate(ReplyBoardVO vo) {
		 mapper.sellerReplyUpdate(vo);
	 }
	 
	 public List<ReplyBoardVO> adminReplyListData(Map map){
		 return mapper.adminReplyListData(map);
	 }
}
