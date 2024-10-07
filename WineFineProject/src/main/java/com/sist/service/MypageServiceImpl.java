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
	public List<BoardVO> myBoardListData(int start, int end, String id) {
		// TODO Auto-generated method stub
		return dao.myBoardListData(start, end, id);
	}

}
