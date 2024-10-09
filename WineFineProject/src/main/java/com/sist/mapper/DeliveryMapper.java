package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface DeliveryMapper {
	@Select("SELECT * FROM wine_delivery WHERE userId=#{userId} ORDER BY state DESC, wdno DESC")
	public List<DeliveryVO> myDeliveryList(String userId);
	
	@Insert("INSERT INTO wine_delivery values((SELECT NVL(MAX(wdno)+1, 1) FROM wine_delivery), #{name}, #{userId}, #{post}, #{addr1}, #{addr2}, #{msg}, #{state})")
	public void deliveryInsert(DeliveryVO vo);
	
	@Update("UPDATE wine_delivery SET state=0 WHERE userId=#{userId}")
	public void deliveryStateUpdate1(String userId);
	
	@Update("UPDATE wine_delivery SET state=1 WHERE wdno=(SELECT NVL(MAX(wdno), 1) FROM wine_delivery WHERE userId=#{userId})")
	public void deliveryStateUpdate2(String userId);
	
	@Update("UPDATE wine_delivery SET state=1 WHERE wdno=#{wdno}")
	public void deliveryStateUpdate3(int wdno);
	
	@Delete("DELETE FROM wine_delivery WHERE wdno=#{wdno}")
	public void deliveryStateDelete(int wdno);
}
