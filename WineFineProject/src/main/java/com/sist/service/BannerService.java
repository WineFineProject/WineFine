package com.sist.service;

import java.util.List;

import com.sist.vo.PromotionBannerVO;

public interface BannerService {
	public void promotionBannerInput(PromotionBannerVO vo);
	public List<PromotionBannerVO> promotionWaitBanner(String id);
	public List<PromotionBannerVO> promotionActiveBanner(String id);
	public void promotionApproval(int pbno);
	public void promotionRejection(int pbno);
	public List<PromotionBannerVO> promotionBannerList();
	public void promotionclick(int pbno);
	public void bannerDelete(int pbno);
}
