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
}
