package com.sist.service;
import java.util.*;
import com.sist.vo.*;
public interface ReplyBoardService {
	public List<ReplyBoardVO> replyListData(int start, int end, String userid);
	public int replyCount();
	public void replyInsert(ReplyBoardVO vo);
	public ReplyBoardVO replyDetailData(int wrno);
	public void replyDelete(int group_id);
	public void replyUpdateData(ReplyBoardVO vo);
	public ReplyBoardVO replyDetail(int wrno);
	public int sellerReplyCount(String userid);
	public List<ReplyBoardVO> sellrReplyListData(Map map);
	public void sellerReplyInsert(ReplyBoardVO vo);
	public ReplyBoardVO replyAnswerDetailData(int group_id);
	public void replyAnswerDelete(int wrno);
	public void sellerReplyUpdate(ReplyBoardVO vo);
	public List<ReplyBoardVO> adminReplyListData(Map map);
	public List<ReplyBoardVO> shopReplyListData(int count, String userid,int wno);
	public int shopReplyTotalPage(int wno);
	public int shopReplyCount();
}
