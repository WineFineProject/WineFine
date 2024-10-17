package com.sist.dao;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.vo.BoardVO;
import com.sist.vo.MemberVO;
import com.sist.mapper.MypageMapper;

@Repository
public class MyPageDAO {
	@Autowired
	private MypageMapper mapper;
	
	// 개인 정보 수정
	public MemberVO getMyId(String userId) {
		return mapper.getMyId(userId);
	}

	public MemberVO updateMyInfo(MemberVO vo) {
		int result = mapper.updateMyInfo(vo);
		if (result>0) {
			return mapper.getMyId(vo.getUserId());
		}
		return null;
	}

	// 작성 글 목록
	public List<BoardVO> myBoardListData(String nickName) {
		return mapper.myBoardListData(nickName);      
	}

	public int myPageBoardTotalPage(Map map) {
		return mapper.myPageBoardTotalPage(map);
	}

}
