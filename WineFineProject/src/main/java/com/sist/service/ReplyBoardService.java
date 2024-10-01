package com.sist.service;
import java.util.*;
import com.sist.vo.*;
public interface ReplyBoardService {
	public List<ReplyBoardVO> replyListData(int start, int end);
	public int replyCount();
	public void replyInsert(ReplyBoardVO vo);
	public ReplyBoardVO replyDetailData(int wrno);
}
