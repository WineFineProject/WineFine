package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MyPageDAO;
import com.sist.vo.BoardVO;

@Service
public class MypageServiceImpl implements MypageService {
	@Autowired
	private MyPageDAO dao;

	@Override
	public List<BoardVO> myBoardListData(String nickname, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardTypeListData(nickname, end, start, end);
	}

	@Override
	public List<BoardVO> boardTypeListData(String nickname, int type, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardTypeListData(nickname, type, start, end);
	}

	@Override
	public int myPageBoardTotalPage(String nickname) {
		// TODO Auto-generated method stub
		return dao.myPageBoardTotalPage(nickname);
	}

	@Override
	public int myPageCBoardTotalPage(String nickname, int type) {
		// TODO Auto-generated method stub
		return dao.myPageCBoardTotalPage(nickname, type);
	}
	
	
}
