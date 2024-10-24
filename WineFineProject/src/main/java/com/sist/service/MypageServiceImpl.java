package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MyPageDAO;
import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.MemberVO;
import com.sist.vo.ReplyBoardVO;

@Service
public class MypageServiceImpl implements MypageService {
	@Autowired
	private MyPageDAO dao;

	@Override
	public MemberVO getMyId(String userId) {
		// TODO Auto-generated method stub
		return dao.getMyId(userId);
	}

	@Override
	public void updateMyInfo(MemberVO vo) {
		// TODO Auto-generated method stub
		dao.updateMyInfo(vo);
	}

	@Override
	public List<BoardVO> myBoardListData(Map map) {
		// TODO Auto-generated method stub
		return dao.myBoardListData(map);
	}

	@Override
	public int myPageBoardTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.myPageBoardTotalPage(map);
	}

	@Override
	public List<ReplyBoardVO> myReplyListData(Map map) {
		// TODO Auto-generated method stub
		return dao.myReplyListData(map);
	}

	@Override
	public List<BoardReplyVO> myboardReplyListData(Map map) {
		// TODO Auto-generated method stub
		return dao.myboardReplyListData(map);
	}

	@Override
	public int myReplyTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.myReplyTotalPage(map);
	}

	@Override
	public int myboardReplyTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.myboardReplyTotalPage(map);
	}

	

	
}
