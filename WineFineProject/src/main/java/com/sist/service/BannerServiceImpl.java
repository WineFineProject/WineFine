package com.sist.service;

import java.util.List;

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
	@Override
	public List<PromotionBannerVO> promotionActiveBanner(String id) {
		return dao.promotionActiveBanner(id);
	}
	@Override
	public List<PromotionBannerVO> promotionWaitBanner(String id) {
		return dao.promotionWaitBanner(id);
	}
	@Override
	public void promotionApproval(int pbno) {
		dao.promotionApproval(pbno);
	}
	@Override
	public void promotionRejection(int pbno) {
		dao.promotionRejection(pbno);
	}
	@Override
	public List<PromotionBannerVO> promotionBannerList() {
		return dao.promotionBannerList();
	}
	@Override
	public void promotionclick(int pbno) {
		dao.promotionclick(pbno);
	}
	@Override
	public void bannerDelete(int pbno) {
		dao.bannerDelete(pbno);
	}
}
