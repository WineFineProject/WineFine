package com.sist.dao;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.MemberVO;
import com.sist.vo.ReplyBoardVO;
import com.sist.mapper.MypageMapper;

@Repository
public class MyPageDAO {
	@Autowired
	private MypageMapper mapper;
	
	// 개인 정보 수정
	public MemberVO getMyId(String userId) {
		return mapper.getMyId(userId);
	}

	public void updateMyInfo(MemberVO vo) {
		mapper.updateMyInfo(vo);
	}

	// 작성 글 목록
	public List<BoardVO> myBoardListData(Map map) {
		return mapper.myBoardListData(map);   
	}
	public List<ReplyBoardVO> myReplyListData(Map map){
		return mapper.myReplyListData(map);
	}
	// 총페이지
	public int myPageBoardTotalPage(Map map)
	{
		return mapper.myPageBoardTotalPage(map);
	}
	public int myReplyTotalPage(Map map)
	{
		return mapper.myReplyTotalPage(map);
	}
	public int myboardReplyTotalPage(Map map)
	{
		return mapper.myboardReplyTotalPage(map);
	}
	// 작성 댓글 목록
	public List<BoardReplyVO> myboardReplyListData(Map map)
	{
		return mapper.myboardReplyListData(map);
	}

	
	

}
