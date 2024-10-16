package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MyPageDAO;
import com.sist.vo.BoardVO;
import com.sist.vo.MemberVO;

@Service
public class MypageServiceImpl implements MypageService {
	@Autowired
	private MyPageDAO dao;

	@Override
	public List<BoardVO> myboardListData(String nickName) {
		// TODO Auto-generated method stub
		return dao.myBoardListData(nickName);
	}
	

	@Override
	public int myPageBoardTotalPage(String nickName) {
		// TODO Auto-generated method stub
		return dao.myPageBoardTotalPage(nickName);
	}


	@Override
	public MemberVO getMyId(String userId) {
		// TODO Auto-generated method stub
		return dao.getMyId(userId);
	}


	@Override
	public MemberVO updateMyInfo(MemberVO vo) {
		// TODO Auto-generated method stub
		return dao.updateMyInfo(vo);
	}

	

	
}
