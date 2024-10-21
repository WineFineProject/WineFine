package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.WineReviewMapper;
import com.sist.vo.WineReviewVO;

@Repository
public class WineReviewDAO {
	@Autowired
	private WineReviewMapper mapper;
	
//	추가
	public void reviewInsert(WineReviewVO vo) {
		mapper.reviewInsert(vo);
	}
//	상세
	public List<WineReviewVO> reviewList(int wno,int count) {
		return mapper.reviewList(wno, count);
	}
//	총 리뷰 수
	public int reviewTotalCount(int wno) {
		return mapper.reviewTotalCount(wno);
	}
//	삭제
	public void reviewDelete(WineReviewVO vo) {
		mapper.reviewDelete(vo);
	}
	
	public List<WineReviewVO> myReviewList(Map map){
		return mapper.myReviewList(map);
	}
	
	public int myReviewTotalPage(Map map) {
		return mapper.myReviewTotalPage(map);
	}
	
	// 마이페이지 삭제
	public void mypageReviewDelete(int wrvno) {
		mapper.mypageReviewDelete(wrvno);
	}
	
	// 와인 평점 변경
	public void wineScoreUpdate(int wno) {
		mapper.wineScoreUpdate(wno);
	}
}
