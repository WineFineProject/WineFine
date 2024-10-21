package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
import java.util.*;

public interface SaleMapper {
	// �������θ�� ���
	@Insert("INSERT INTO promotion_sale VALUES((SELECT NVL(MAX(psno)+1, 1) FROM promotion_sale), #{title}, #{userid}, #{discount}, #{type}, #{target}, #{startDay}, #{endDay}, #{state})")
	public void promotionSaleInput(PromotionSaleVO vo);
	
	// ���θ�� ����
	@Update("UPDATE promotion_sale SET state=1 WHERE psno=#{psno}")
	public void promotionApproval(int psno);
	
	// ���θ�� ����
	@Update("UPDATE promotion_sale SET state=2 WHERE psno=#{psno}")
	public void promotionRejection(int psno);
	
	public List<PromotionSaleVO> saleWaitList(String id);
	
	public List<PromotionSaleVO> saleActiveList(String id);
	
	public List<PromotionSaleVO> sellerSaleActiveList(String id);	
	
	@Update("UPDATE promotion_sale SET state=9 WHERE enddate<sysdate")
	public void promotionSaleEndUpdate();
}
