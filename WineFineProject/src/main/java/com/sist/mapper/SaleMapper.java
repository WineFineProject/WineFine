package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
import java.util.*;

public interface SaleMapper {
	// 할인프로모션 등록
	@Insert("INSERT INTO promotion_sale VALUES((SELECT NVL(MAX(psno)+1, 1) FROM promotion_sale), #{title}, #{userid}, #{discount}, #{type}, #{target}, #{startDay}, #{endDay}, #{state})")
	public void promotionSaleInput(PromotionSaleVO vo);
	
	// 프로모션 승인
	@Update("UPDATE promotion_sale SET state=1 WHERE psno=#{psno}")
	public void promotionApproval(int psno);
	
	// 프로모션 거절
	@Update("UPDATE promotion_sale SET state=2 WHERE psno=#{psno}")
	public void promotionRejection(int psno);
	
	public List<PromotionSaleVO> saleWaitList(String id);
	
	public List<PromotionSaleVO> saleActiveList(String id);
	
	public List<PromotionSaleVO> sellerSaleActiveList(String id);	
}
