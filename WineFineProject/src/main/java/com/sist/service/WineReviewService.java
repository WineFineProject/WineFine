package com.sist.service;

import java.util.List;

import com.sist.vo.WineReviewVO;

public interface WineReviewService {
	
	public void reviewInsert(WineReviewVO vo);
//	상세
	public List<WineReviewVO> reviewList(int wno, int count);
//	총 리뷰 수
	public WineReviewVO reviewTotalCount(int wno);
//	삭제
	public void reviewDelete(WineReviewVO vo);
	
}
