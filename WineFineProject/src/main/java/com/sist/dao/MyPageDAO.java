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
	
    public List<BoardVO> myBoardListData(int start,int end,String id){
    	
    	return mapper.myBoardListData(start, end, id);
    }
}
