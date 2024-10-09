package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface ShopMapper {
	/*
	WNO NAMEKOR NAMEENG TYPE PRICE VOL SUGAR ACID BODY TANNIN AROMA FOOD
	MAKER NATION GRAPE ALCOHOL SELLER STACK SCORE HIT REGDATE LIKECOUNT POSTER STATE
	 */
//	占쏙옙占쎌뵥 �뵳�딅뮞占쎈뱜
	@Select("SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, rownum as num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster "
	        + "FROM wine ORDER BY wno ASC, state DESC)) "
	        + "WHERE num BETWEEN #{start} AND #{end}")
	public List<WineVO> wineListData(@Param("start")int start,@Param("end")int end);
//	占쏙옙占쎌뵥 �룯占� 占쎈읂占쎌뵠筌욑옙
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
	
//	�긽�꽭蹂닿린
	@Update("UPDATE wine SET "
			+ "hit=hit+1 "
			+ "WHERE wno=#{wno} ")
	public void hitIncrement(int wno);
	
//  �룷�룄紐� 媛��졇�삤湲�
	@Select("SELECT namekor FROM grape WHERE (SELECT grape FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> grapeName(int wno);

//	�굹�씪紐� 媛��졇�삤湲�
	@Select("SELECT namekor FROM nation WHERE (SELECT nation FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> nationName(int wno); 
	
//  媛숈� �깮�궛�옄媛� 留뚮뱺 �떎瑜� ���씤
	@Select("SELECT wno "
			+ "FROM wine "
			+ "WHERE (select maker from wine where wno = #{wno}) = maker")
	public List<String> anotherWine(int wno);
	

	@Select("SELECT w.wno, w.vol, w.type, w.tannin, w.sugar, w.state, w.stack, "
	        + "w.seller, w.score, w.regdate, w.price, w.poster, w.nation, "
	        + "w.namekor, w.nameeng, w.maker, w.likecount, w.hit, w.grape, "
	        + "w.food, w.body, w.aroma, w.alcohol, w.acid, "
	        + "m.namekor AS makerkor, m.nameeng AS makereng "
	        + "FROM wine w "
	        + "LEFT JOIN maker m ON TO_NUMBER(w.maker) = m.no "
	        + "WHERE w.wno = #{wno}")
	public WineVO wineDetailData(int wno);

//	구매하기 
	@Select("SELECT wno, namekor, TO_NUMBER(REPLACE(REPLACE(price, '원', ''), ',', '')) AS price, poster "
	        + "FROM wine "
	        + "WHERE wno = #{wno}")
	public WineVO winebuy(int wno);

	
////	쿠폰 확인하기
//	@Select("SELECT * "
//			+ "FROM my_coupon "
//			+ "WHERE recvid = #{id} "
//			+ "AND state = 0 ")
//	public MyCouponVO selectCoupon(String id);
	
//	쿠폰 확인하기 test
	@Select("SELECT * "
			+ "FROM my_coupon "
			+ "WHERE state = 0 ")
	public List<MyCouponVO> selectCoupon(String id);
	
//	쿠폰 사용하기
	@Update("UPDATE my_coupon "
			+ "SET state = 1 "
			+ "WHERE recvid = #{id} ")
	public MyCouponVO useCoupon(String id);
}




