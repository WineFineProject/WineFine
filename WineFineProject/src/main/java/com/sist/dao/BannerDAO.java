package com.sist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.BannerMapper;
import com.sist.vo.PromotionBannerVO;

@Repository
public class BannerDAO {
	@Autowired
	private BannerMapper mapper;

	public void promotionBannerInput(PromotionBannerVO vo) {
		mapper.promotionBannerInput(vo);
	}

	public List<PromotionBannerVO> promotionWaitBanner(String id) {
		return mapper.promotionWaitBanner(id);
	}

	public List<PromotionBannerVO> promotionActiveBanner(String id) {
		return mapper.promotionActiveBanner(id);
	}

	public void promotionApproval(int pbno) {
		mapper.promotionApproval(pbno);
	}

	public void promotionRejection(int pbno) {
		mapper.promotionRejection(pbno);
	}

	public List<PromotionBannerVO> promotionBannerList() {
		return mapper.promotionBannerList();
	}
	public List<PromotionBannerVO> promotionBannerList2() {
		return mapper.promotionBannerList2();
	}

	public void promotionclick(int pbno) {
		mapper.promotionStackDecrement(pbno);
		int count = mapper.promtionStack(pbno);
		if (count == 0)
			mapper.promotionBannerEnd(pbno);
	}
	
	public void bannerDelete(int pbno) {
		mapper.bannerDelete(pbno);
	}

}
