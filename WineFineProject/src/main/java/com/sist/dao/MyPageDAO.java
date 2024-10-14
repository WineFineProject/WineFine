package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.vo.BoardVO;
import com.sist.mapper.MypageMapper;
@Repository
public class MyPageDAO {
	@Autowired
	private MypageMapper mapper;
	  public List<BoardVO> myBoardListData(String nickname,int start,int end){
		  return mapper.myBoardListData(nickname, start, end);
	  }
	  public int myPageBoardTotalPage(String nickname) {
		  return mapper.myPageBoardTotalPage(nickname);
	  }
}
