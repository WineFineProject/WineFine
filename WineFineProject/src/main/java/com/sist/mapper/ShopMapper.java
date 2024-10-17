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
//	와인 리스트
	@Select("SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, rownum as num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster "
	        + "FROM wine ORDER BY wno ASC, state DESC)) "
	        + "WHERE num BETWEEN #{start} AND #{end}")
	public List<WineVO> wineListData(@Param("start")int start,@Param("end")int end);
//	총 페이지
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
	
//	조회수
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

	
//	와인 상세보기
	@Select("SELECT w.wno, w.vol, w.type, w.tannin, w.sugar, w.state, w.stack, "
	        + "w.seller, w.score, w.regdate, w.price, w.poster, w.nation, "
	        + "w.namekor, w.nameeng, w.maker, w.likecount, w.hit, w.grape, "
	        + "w.food, w.body, w.aroma, w.alcohol, w.acid, "
	        + "m.namekor AS makerkor, m.nameeng AS makereng "
	        + "FROM wine w "
	        + "LEFT JOIN maker m ON TO_NUMBER(w.maker) = m.no "
	        + "WHERE w.wno = #{wno}")
	public WineVO wineDetailData(int wno);

//	와인구매 정보
	@Select("SELECT wno, namekor, TO_NUMBER(REPLACE(REPLACE(price, '원', ''), ',', '')) AS price, poster, seller, type "
	        + "FROM wine "
	        + "WHERE wno = #{wno}")
	public WineVO winebuy(int wno);

	
//	사용 가능 쿠폰 가져오기
	@Select("SELECT mcno, title, discount, TO_CHAR(enddate,'YYYY-MM-DD') as endDay "
	        + "FROM my_coupon  "
	        + "WHERE recvid = #{id} "
	        + "AND state = 1 "
	        + "AND SYSDATE BETWEEN startdate AND enddate ")
	public List<MyCouponVO> selectCoupon(String id);
	
//	프로모션 세일
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
	public List<PromotionSaleVO> promotionGetSale(Map map);
	
//	같은 생산자
	@Select("SELECT wno, type, namekor, price, vol, poster, hit "
	        + "FROM (SELECT wno, type, namekor, price, vol, poster, hit "
	        + "      FROM wine "
	        + "      WHERE (SELECT maker FROM wine WHERE wno = #{wno}) = maker "
	        + "      ORDER BY hit DESC) "
	        + "WHERE ROWNUM <= 5")
	public List<WineVO> otherWine_maker(int wno);
	
//	같은 판매자 
	@Select("SELECT wno, type, namekor, price, vol, poster, hit "
	        + "FROM (SELECT wno, type, namekor, price, vol, poster, hit "
	        + "      FROM wine "
	        + "      WHERE (SELECT seller FROM wine WHERE wno = #{wno}) = seller "
	        + "      ORDER BY hit DESC) "
	        + "WHERE ROWNUM <= 5")
	public List<WineVO> otherWine_seller(int wno);

//	포인트 가져오기
	@Select("SELECT point "
			+ "FROM wine_member "
			+ "WHERE userid = #{id}")
	public String getPoint(String id);
	
//	회원등급 가져오기
	@Select("SELECT grade "
			+ "FROM wine_member "
			+ "WHERE userid = #{id}")
	public String getgrade(String id);
	
//	배송지 
	@Select("SELECT * "
			+ "FROM wine_delivery "
			+ "WHERE userid = #{id} "
			+ "ORDER BY state DESC ")
	public List<DeliveryVO> getDeli(String id);	
	
//	배송지 추가하기
//	INSERT INTO wine_delivery VALUES ('5','풍성빌딩', 'ping', '01016','서울 강북구 4.19로21길 4', '1212', '1212', 0);
	@Insert("INSERT INTO wine_delivery (name, userid, post, addr1, addr2, msg, status) VALUES (#{name}, #{userid}, #{post}, #{addr1}, #{addr2}, #{msg}, 0) ")
	public void addDeli(DeliveryVO vo);
	
//	사용 적립금 차감하기
	@Update("UPDATE wine_member SET "
			+ "point = point - #{mipoint} "
			+ "WHERE userid = #{userId} ")
	public void usePoint (MemberVO vo);
	
//	결제 적립금 추가하기
	@Update("UPDATE wine_member "
	        + "SET point = point + #{plpoint} "
	        + "WHERE userid = #{userId} ")
	public void plusPoint(MemberVO vo);
	
//	쿠폰 사용
	@Update("UPDATE my_coupon "
			+ "SET state = 0 "
			+ "WHERE mcno = #{mcno} ")
	public void useCoupon(MyCouponVO vo);
	
//	장바구니 저장
	@Insert("INSERT INTO wine_cart (cno, wno, userid, account, regdate) "
	        + "VALUES (wc_cno_seq.nextval, #{wno}, #{userid}, #{account}, SYSDATE)")
	public void insertCart(Wine_CartVO vo);

	@Update("UPDATE wine_cart SET "
			+"account = account + #{account} "
	  	    +"WHERE wno=#{wno}")
	public void wineCartAccountUpdate(Wine_CartVO vo);
	
	@Select("SELECT COUNT(*) FROM wine_cart "
			+"WHERE wno=#{wno}")
	public int wineCartwnoCount(int wno);
	
//	구매 저장
	@Insert("INSERT INTO wine_payment (wpno, wno, account, payment, mipoint, wdno, mcno, psno, state, userid, regdate) "
	        + "VALUES (wp_wpno_seq.nextval, #{wno}, #{account}, #{payment}, #{mipoint}, #{wdno}, "
	        + "#{mcno}, #{psno}, 0, #{userid}, SYSDATE) ")
	public void insertPayment(Wine_PaymentVO vo);
//	구매 추가
	@Update("UPDATE wine_payment SET "
			+ "account = account + #{account} "
			+ "WHERE wno = #{wno} ")
	public void wineBuyAccountUpdate(Wine_PaymentVO vo);
//	
	@Select("SELECT COUNT(*) FROM wine_payment "
			+ "WHERE wpno = #{wpno}")
	public int wineBuywpnoCount(int wpno);
	
//	신고하기
	@Insert("INSERT INTO wine_report (WRENO, USERID, TYPE, TNO, STATE, RID, REGDATE, CONTENT, CATEGORY) "
			+ "VALUES (wre_wreno_seq.nextval, #{userid}, #{type}, "
			+ " #{tno}, #{state}, #{rid}, SYSDATE, #{content}, #{category}) ")
	public void insertReport (Wine_ReportVO vo);
	
}













