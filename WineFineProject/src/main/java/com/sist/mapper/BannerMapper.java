package com.sist.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
import java.util.*;

public interface BannerMapper {
	//��� ���θ�� ��� ��û
	@Insert("INSERT INTO promotion_banner VALUES((SELECT NVL(MAX(pbno)+1, 1) FROM promotion_banner), #{title}, #{userid}, #{stack}, #{wno}, #{type}, null, null, 0)")
	public void promotionBannerInput(PromotionBannerVO vo);
	
	//���� ��� ��� ����
	@Update("UPDATE promotion_banner SET state=1, startdate=sysdate WHERE pbno=#{pbno}")
	public void promotionApproval(int pbno);
	
	// ���� ��� ��� ����
	@Update("Update promotion_banner SET state=2 WHERE pbno=#{pbno}")
	public void promotionRejection(int pbno);
	
	//
	@Update("UPDATE promotion_banner SET stack=stack-1 WHERE pbno=#{pbno}")
	public void promotionStackDecrement(int pbno);
	
	@Select("SELECT stack FROM promotion_banner WHERE pbno=#{pbno}")
	public int promtionStack(int pbno);
	
	@Update("UPDATE promotion_banner SET state=9, enddate=sysdate WHERE pbno=#{pbno}")
	public void promotionBannerEnd(int pbno);
	
	public List<PromotionBannerVO> promotionWaitBanner(String id);
	public List<PromotionBannerVO> promotionActiveBanner(String id);
	public List<PromotionBannerVO> promotionBannerList();
}
