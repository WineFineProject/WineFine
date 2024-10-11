package com.sist.service;

import java.util.List;

import com.sist.vo.BoardVO;

public interface MypageService {
	 public List<BoardVO> myBoardListData(String nickname,int start,int end);
	 public List<BoardVO> boardTypeListData(String nickname,int type,int start,int end);
	 public int myPageBoardTotalPage(String nickname);
	 public int myPageCBoardTotalPage(String nickname,int type);

}
