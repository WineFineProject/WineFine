package com.sist.dao;

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
}
