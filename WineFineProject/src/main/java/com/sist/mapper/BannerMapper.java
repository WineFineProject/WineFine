package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
import java.util.*;

public interface BannerMapper {
	//배너 프로모션 등록 신청
	@Insert("INSERT INTO promotion_banner VALUES((SELECT NVL(MAX(pbno)+1, 1) FROM promotion_banner), #{title}, #{userid}, #{stack}, #{wno}, #{type}, null, null, 0)")
	public void promotionBannerInput(PromotionBannerVO vo);
	
	//승인 대기 배너 승인
	@Update("UPDATE promotion_banner SET state=1, startdate=sysdate WHERE pbno=#{pbno}")
	public void promotionApproval(int pbno);
	
	// 승인 대기 배너 거절
	@Update("Update promotion_banner SET state=2 WHERE pbno=#{pbno}")
	public void promotionRejection(int pbno);
	
	public List<PromotionBannerVO> promotionWaitBanner(String id);
	public List<PromotionBannerVO> promotionActiveBanner(String id);
}
