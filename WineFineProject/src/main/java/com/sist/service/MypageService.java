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
	//public List<BoardVO> myBoardListData(String nickname,int start,int end);
//public List<BoardVO> boardTypeListData(String nickname,int type,int start,int end);
//public int myPageBoardTotalPage(String nickname);
//public int myPageCBoardTotalPage(String nickname,int type);
public int nickCheck(String nickName,String userId);
public int phoneCheck(String phone,String userId); 
public int emailCheck(String email,String userId);
public String memberGetPwd(String userId);
//public int nickCheck(Map map);
	
	
	public int myReplyTotalPage(Map map);
	public int myboardReplyTotalPage(Map map);
	public int myreservecount(String userid);
	public void bchangenick(String userid);
	public void brchangenick(String userid);
	public void reviewdelete(String userid);
	public void likedelete(String userid);
	public void reservedelete(String userid);
	public String pwdCheck(String userid);
	public void pwdcancel(String userid);
	public int ingpaycount(String userid);
	public void Authorityupdate(String userid);
	public void updatePwd(String userid,String userpwd);
}
