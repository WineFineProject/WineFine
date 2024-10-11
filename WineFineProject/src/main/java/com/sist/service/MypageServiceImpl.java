package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MyPageDAO;
import com.sist.vo.BoardVO;

@Service
public class MypageServiceImpl implements MypageService {
	@Autowired
	private MyPageDAO dao;

	@Override
	public List<BoardVO> getBoardsByUserId(String userId) {
		// TODO Auto-generated method stub
		return dao.getBoardsByUserId(userId);
	}

	@Override
	public int getboardCountByUserId(String userId) {
		// TODO Auto-generated method stub
		return dao.getboardCountByUserId(userId);
	}

	@Override
	public List<BoardVO> getBoardsByUserIdWithPaging(String userId, int limit, int offset) {
		// TODO Auto-generated method stub
		return dao.getBoardsByUserIdWithPaging(userId, limit, offset);
	}

	@Override
	public List<Map<String, Object>> getBoardCountByCategoryForUser(String userId) {
		// TODO Auto-generated method stub
		return dao.getBoardCountByCategoryForUser(userId);
	}

//	@Override
//	public List<BoardVO> myBoardListData(String nickname, int start, int end) {
//		// TODO Auto-generated method stub
//		return dao.myBoardListData(nickname, start, end);
//	}
//
//	@Override
//	public List<BoardVO> boardTypeListData(String nickname, int type, int start, int end) {
//		// TODO Auto-generated method stub
//		return dao.boardTypeListData(nickname, type, start, end);
//	}
//
//	@Override
//	public int myPageBoardTotalPage(String nickname) {
//		// TODO Auto-generated method stub
//		return dao.myPageBoardTotalPage(nickname);
//	}
//
//	@Override
//	public int myPageCBoardTotalPage(String nickname, int type) {
//		// TODO Auto-generated method stub
//		return dao.myPageCBoardTotalPage(nickname, type);
//	}
	
	
}
