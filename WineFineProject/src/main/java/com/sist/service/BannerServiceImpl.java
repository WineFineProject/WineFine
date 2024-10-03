package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.BannerDAO;
import com.sist.vo.PromotionBannerVO;

@Service
public class BannerServiceImpl implements BannerService{
	@Autowired
	private BannerDAO dao;
	@Override
	public void promotionBannerInput(PromotionBannerVO vo) {
		dao.promotionBannerInput(vo);
	}
}
