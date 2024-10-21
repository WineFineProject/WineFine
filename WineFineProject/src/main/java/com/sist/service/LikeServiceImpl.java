package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.LikeDAO;
import com.sist.vo.LikeVO;

@Service
public class LikeServiceImpl implements LikeService{
	@Autowired
	private LikeDAO ldao;
	@Override
	public int wineLikeOn(int wno, String userId) {
		// TODO Auto-generated method stub
		return ldao.wineLikeOn(wno, userId);
	}

	@Override
	public int wineLikeOff(int wno,String userId) {
		// TODO Auto-generated method stub
		return ldao.wineLikeOff(wno, userId);
	}

	@Override
	public int wineLikeCount(int wno) {
		// TODO Auto-generated method stub
		return ldao.wineLikeCount(wno);
	}

	@Override
	public int likeCheck(int wno, String userId) {
		// TODO Auto-generated method stub
		return ldao.likeCheck(wno, userId);
	}
	
}
