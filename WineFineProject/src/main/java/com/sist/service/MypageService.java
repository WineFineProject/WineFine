package com.sist.service;

import java.util.*;


import com.sist.vo.BoardVO;

public interface MypageService {
	public List<BoardVO> getBoardsByUserId(String userId);	
	int getboardCountByUserId(String userId);
	public List<BoardVO> getBoardsByUserIdWithPaging(String userId,int limit,int offset);	
	public List<Map<String, Object>> getBoardCountByCategoryForUser(String userId);

	
//	 public List<BoardVO> myBoardListData(String nickname,int start,int end);
//	 public List<BoardVO> boardTypeListData(String nickname,int type,int start,int end);
//	 public int myPageBoardTotalPage(String nickname);
//	 public int myPageCBoardTotalPage(String nickname,int type);

}
