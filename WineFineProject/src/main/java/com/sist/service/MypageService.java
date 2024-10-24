package com.sist.service;

import java.util.*;

import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.MemberVO;
import com.sist.vo.ReplyBoardVO;

public interface MypageService {

	public MemberVO	getMyId(String userId);
	public void updateMyInfo(MemberVO vo);
	public List<BoardVO> myBoardListData(Map map);
	public List<ReplyBoardVO> myReplyListData(Map map);
	public List<BoardReplyVO> myboardReplyListData(Map map);
	public int myPageBoardTotalPage(Map map);
	public int myReplyTotalPage(Map map);
	public int myboardReplyTotalPage(Map map);

}
