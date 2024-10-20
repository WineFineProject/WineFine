package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.WineReviewDAO;
import com.sist.vo.WineReviewVO;

@Service
public class WineReviewServiceImpl implements WineReviewService{
	@Autowired
	private WineReviewDAO wdao;

	@Override
	public void reviewInsert(WineReviewVO vo) {
		// TODO Auto-generated method stub
		wdao.reviewInsert(vo);
	}

	@Override
	public List<WineReviewVO> reviewList(int wno, int count) {
		// TODO Auto-generated method stub
		return wdao.reviewList(wno, count);
	}

	@Override
	public WineReviewVO reviewTotalCount(int wno) {
		// TODO Auto-generated method stub
		return wdao.reviewTotalCount(wno);
	}

	@Override
	public void reviewDelete(WineReviewVO vo) {
		// TODO Auto-generated method stub
		wdao.reviewDelete(vo);
	}
	
	@Override
	public List<WineReviewVO> myReviewList(Map map) {
		return wdao.myReviewList(map);
	}
	
	@Override
	public int myReviewTotalPage(Map map) {
		return wdao.myReviewTotalPage(map);
	}
	
	@Override
	public void mypageReviewDelete(int wrvno) {
		wdao.mypageReviewDelete(wrvno);
	}
	
	@Override
	public void wineScoreUpdate(int wno) {
		wdao.wineScoreUpdate(wno);
	}
}
