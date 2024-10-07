package com.sist.service;

import java.util.List;

import com.sist.vo.BoardVO;

public interface MypageService {
	 public List<BoardVO> myBoardListData(int start,int end,String id);
}
