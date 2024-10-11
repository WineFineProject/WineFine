package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.vo.BoardVO;
import com.sist.mapper.MypageMapper;
@Repository
public class MyPageDAO {
	@Autowired
	private MypageMapper mapper;
	
	
	public List<BoardVO> getBoardsByUserId(String userId)
    {
    	return mapper.getBoardsByUserId(userId);
    }
	
	public int getboardCountByUserId(String userId)
	{
		return mapper.getboardCountByUserId(userId);
	}

	public List<BoardVO> getBoardsByUserIdWithPaging(String userId,int limit,int offset){
		return mapper.getBoardsByUserIdWithPaging(userId, limit, offset);
	}
	
	public List<Map<String, Object>> getBoardCountByCategoryForUser(String userId){
		return mapper.getBoardCountByCategoryForUser(userId);
	}
	 
	 
	 
//    public List<BoardVO> myBoardListData(String nickname,int start,int end){
//    	
//    	return mapper.myBoardListData(nickname,start, end);
//    	
//    }
//    public List<BoardVO> boardTypeListData(String nickname,int type,int start,int end){
//    	return mapper.boardTypeListData(nickname, type, start, end);
//    }
//    
//    public int myPageBoardTotalPage(String nickname) {
//    	return mapper.myPageBoardTotalPage(nickname);
//    }
//    	
//    	
//    public int myPageCBoardTotalPage(String nickname,int type) {
//    	return mapper.myPageCBoardTotalPage(nickname, type);
//    }
//    
}
