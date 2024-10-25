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

	@Override
	public int myreservecount(String userid) {
		// TODO Auto-generated method stub
		return dao.myreservecount(userid);
	}

	@Override
	public void bchangenick(String userid) {
		// TODO Auto-generated method stub
		dao.bchangenick(userid);
	}

	@Override
	public void brchangenick(String userid) {
		// TODO Auto-generated method stub
		dao.brchangenick(userid);
	}

	@Override
	public void reviewdelete(String userid) {
		// TODO Auto-generated method stub
		dao.reviewdelete(userid);
	}

	@Override
	public void likedelete(String userid) {
		// TODO Auto-generated method stub
		dao.likedelete(userid);
	}

	@Override
	public void reservedelete(String userid) {
		// TODO Auto-generated method stub
		dao.reservedelete(userid);
	}

	@Override
	public String pwdCheck(String userid) {
		// TODO Auto-generated method stub
		return dao.pwdCheck(userid);
	}

	@Override
	public void pwdcancel(String userid) {
		// TODO Auto-generated method stub
		dao.pwdcancel(userid);
	}

	@Override
	public int ingpaycount(String userid) {
		// TODO Auto-generated method stub
		return dao.ingpaycount(userid);
	}

	@Override
	public void Authorityupdate(String userid) {
		// TODO Auto-generated method stub
		dao.Authorityupdate(userid);
	}

	@Override
	public void updatePwd(String userid,String userpwd) {
		// TODO Auto-generated method stub
		dao.updatePwd(userid, userpwd);
	}

	

	
}
