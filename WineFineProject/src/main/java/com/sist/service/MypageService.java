package com.sist.service;

import java.util.*;


import com.sist.vo.BoardVO;
import com.sist.vo.MemberVO;

public interface MypageService {

	public List<BoardVO> myBoardListData(String nickName);
	public int myPageBoardTotalPage(Map map);
//	 public List<BoardVO> myBoardListData(String nickname,int start,int end);
//	 public List<BoardVO> boardTypeListData(String nickname,int type,int start,int end);
//	 public int myPageBoardTotalPage(String nickname);
//	 public int myPageCBoardTotalPage(String nickname,int type);
	public MemberVO	getMyId(String userId);
	public MemberVO updateMyInfo(MemberVO vo);
}
