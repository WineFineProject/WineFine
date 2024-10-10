package com.sist.dao;

import java.util.List;

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
	
    public List<BoardVO> myBoardListData(String nickname,int start,int end){
    	
    	return mapper.myBoardListData(start, end, id);
    	
    }
    public List<BoardVO> boardTypeListData(String nickname,int type,int start,int end){
    	return mapper.boardTypeListData(nickname, type, start, end);
  
    public int myPageBoardTotalPage(String nickname) {
    	return mapper.myPageBoardTotalPage(nickname);
    }
    	
    	
    public int myPageCBoardTotalPage(String nickname,int type) {
    	return mapper.myPageCBoardTotalPage(nickname, type);
    }
    }
}
