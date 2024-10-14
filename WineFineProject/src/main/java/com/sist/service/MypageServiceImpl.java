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
	public List<BoardVO> myboardListData(String nickname, int start, int end) {
		// TODO Auto-generated method stub
		return dao.myBoardListData(nickname, start, end);
	}
	

	@Override
	public int myPageBoardTotalPage(String nickname) {
		// TODO Auto-generated method stub
		return dao.myPageBoardTotalPage(nickname);
	}

	

	
}
