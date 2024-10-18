package com.sist.dao;

import java.util.List;

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
	public WineReviewVO reviewTotalCount(int wno) {
		return mapper.reviewTotalCount(wno);
	}
//	삭제
	public void reviewDelete(WineReviewVO vo) {
		mapper.reviewDelete(vo);
	}
}
