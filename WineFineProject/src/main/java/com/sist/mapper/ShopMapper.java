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
//	리스트출력
	@Select("SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, rownum as num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster "
	        + "FROM wine ORDER BY wno ASC, state DESC)) "
	        + "WHERE num BETWEEN #{start} AND #{end}")
	public List<WineVO> wineListData(@Param("start")int start,@Param("end")int end);
//	상품 전체페이지
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
	
//	조회수 증가
	@Update("UPDATE wine SET "
			+ "hit=hit+1 "
			+ "WHERE wno=#{wno} ")
	public void hitIncrement(int wno);
	
//  포도명
	@Select("SELECT namekor FROM grape WHERE (SELECT grape FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> grapeName(int wno);

//	나라명
	@Select("SELECT namekor FROM nation WHERE (SELECT nation FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> nationName(int wno); 
	
//  관련 와인
	@Select("SELECT wno "
			+ "FROM wine "
			+ "WHERE (select maker from wine where wno = #{wno}) = maker")
	public List<String> anotherWine(int wno);
	
//	와인 디테일 페이지
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
	@Select("SELECT wno, namekor, TO_NUMBER(REPLACE(REPLACE(price, '원', ''), ',', '')) AS price, poster, seller, type "
	        + "FROM wine "
	        + "WHERE wno = #{wno}")
	public WineVO winebuy(int wno);

	
//	쿠폰 전체 리스트 가져오기 
	@Select("SELECT title, discount, TO_CHAR(enddate,'YYYY-MM-DD') as endDay "
	        + "FROM my_coupon  "
	        + "WHERE recvid = #{id} "
	        + "AND state = 0 "
	        + "AND SYSDATE BETWEEN startdate AND enddate ")
	public List<MyCouponVO> selectCoupon(String id);

	
////	쿠폰 확인하기 test
//	@Select("SELECT title,discount "
//			+ "FROM my_coupon "
//			+ "WHERE state = 0 ")
//	public List<MyCouponVO> selectCoupon(String id);
	
//	쿠폰 사용하기
	@Update("UPDATE my_coupon "
			+ "SET state = 1 "
			+ "WHERE recvid = #{id} ")
	public MyCouponVO useCoupon(String id);
	
//	프로모션 가장 높은 값 가져오기
	@Select("WITH filtered_promotion_sale AS ( "
			+ "  SELECT * "
			+ "  FROM promotion_sale "
			+ "  WHERE userid = #{seller} "
			+ "    AND sysdate BETWEEN startdate AND enddate "
			+ "    AND state = 1 "
			+ "    AND "
			+ "		 (type = 1 OR  "
			+ "      (type = 3 AND target = #{wno}) OR  "
			+ "      (type = 2 AND target = #{type}))) "
			+ "SELECT * "
			+ "FROM filtered_promotion_sale "
			+ "ORDER BY discount DESC "
			+ "FETCH FIRST 1 ROWS ONLY ")
	public PromotionSaleVO promotionGetSale(Map map);
}




