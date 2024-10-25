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
//	와인 총 갯수
	@Select("SELECT COUNT(*) "
			+ "FROM wine")
	public int wineCount();
//	���씤 由ъ뒪�듃
	@Select("SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, rownum as num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster "
	        + "FROM wine ORDER BY wno ASC, state DESC)) "
	        + "WHERE num BETWEEN #{start} AND #{end}")
	public List<WineVO> wineListData(@Param("start")int start,@Param("end")int end);
	/////////////////////////////////////////////////////////////////////////////////////////////////
	@Select("<script>"
	        + "SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, num "
	        + "FROM ( "
	        + "    SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, rownum as num "
	        + "    FROM ( "
	        + "        SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster "
	        + "        FROM wine "
	        + "        WHERE 1=1 "
	        + "        <if test='filters.type != null'>"
	        + "            AND type LIKE '%' || #{filters.type} || '%' "
	        + "        </if>"
	        + "        <if test='filters.food != null'>"
	        + "            AND food LIKE '%' || #{filters.food} || '%' "
	        + "        </if>"
	        + "        <if test='filters.aroma != null'>"
	        + "            AND aroma LIKE '%' || #{filters.aroma} || '%' "
	        + "        </if>"
	        + "        <if test='filters.sugar != null'>"
	        + "            AND sugar LIKE '%' || #{filters.sugar} || '%' "
	        + "        </if>"
	        + "        <if test='filters.acid != null'>"
	        + "            AND acid LIKE '%' || #{filters.acid} || '%' "
	        + "        </if>"
	        + "        <if test='filters.body != null'>"
	        + "            AND body LIKE '%' || #{filters.body} || '%' "
	        + "        </if>"
	        + "        <if test='filters.tannin != null'>"
	        + "            AND tannin LIKE '%' || #{filters.tannin} || '%' "
	        + "        </if>"
	        + "        ORDER BY wno ASC "
	        + "    ) "
	        + ") "
	        + "WHERE num BETWEEN #{start} AND #{end}"
	        + "</script>")
	public List<WineVO> wineFilter(Map map);

	/////////////////////////////////////////////////////////////////////////////////////////////////
//	珥� �럹�씠吏�
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
	
//	議고쉶�닔
	@Update("UPDATE wine SET "
			+ "hit=hit+1 "
			+ "WHERE wno=#{wno} ")
	public void hitIncrement(int wno);
	
//  �룷�룄紐�
	@Select("SELECT namekor FROM grape WHERE (SELECT grape FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> grapeName(int wno);

//	�굹�씪紐�
	@Select("SELECT namekor FROM nation WHERE (SELECT nation FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> nationName(int wno); 

	
//	���씤 �긽�꽭蹂닿린
	@Select("SELECT w.wno, w.vol, w.type, w.tannin, w.sugar, w.state, w.stack, "
	        + "w.seller, w.score, w.regdate, w.price, w.poster, w.nation, "
	        + "w.namekor, w.nameeng, w.maker, w.likecount, w.hit, w.grape, "
	        + "w.food, w.body, w.aroma, w.alcohol, w.acid, w.nbno, "
	        + "m.namekor AS makerkor, m.nameeng AS makereng "
	        + "FROM wine w "
	        + "LEFT JOIN maker m ON TO_NUMBER(w.maker) = m.no "
	        + "WHERE w.wno = #{wno}")
	public WineVO wineDetailData(int wno);

//	���씤援щℓ �젙蹂�
	@Select("SELECT wno, namekor, TO_NUMBER(REPLACE(REPLACE(price, '원', ''), ',', '')) AS price, poster, seller, type "
	        + "FROM wine "
	        + "WHERE wno = #{wno}")
	public WineVO winebuy(int wno);

	
//	�궗�슜 媛��뒫 荑좏룿 媛��졇�삤湲�
	@Select("SELECT mcno, title, discount, TO_CHAR(enddate,'YYYY-MM-DD') as endDay "
	        + "FROM my_coupon  "
	        + "WHERE recvid = #{id} "
	        + "AND state = 0 "
	        + "AND SYSDATE BETWEEN startdate AND enddate ")
	public List<MyCouponVO> selectCoupon(String id);
	
//	�봽濡쒕え�뀡 �꽭�씪
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
	
//	媛숈� �깮�궛�옄
	@Select("SELECT wno, type, namekor, price, vol, poster, hit "
	        + "FROM (SELECT wno, type, namekor, price, vol, poster, hit "
	        + "      FROM wine "
	        + "      WHERE (SELECT maker FROM wine WHERE wno = #{wno}) = maker "
	        + "      ORDER BY hit DESC) "
	        + "WHERE ROWNUM <= 5")
	public List<WineVO> otherWine_maker(int wno);
	
//	媛숈� �뙋留ㅼ옄 
	@Select("SELECT wno, type, namekor, price, vol, poster, hit "
	        + "FROM (SELECT wno, type, namekor, price, vol, poster, hit "
	        + "      FROM wine "
	        + "      WHERE (SELECT seller FROM wine WHERE wno = #{wno}) = seller "
	        + "      ORDER BY hit DESC) "
	        + "WHERE ROWNUM <= 5")
	public List<WineVO> otherWine_seller(int wno);

//	�룷�씤�듃 媛��졇�삤湲�
	@Select("SELECT point "
			+ "FROM wine_member "
			+ "WHERE userid = #{id}")
	public String getPoint(String id);
	
//	�쉶�썝�벑湲� 媛��졇�삤湲�
	@Select("SELECT grade "
			+ "FROM wine_member "
			+ "WHERE userid = #{id}")
	public String getgrade(String id);
	
//	諛곗넚吏� 
	@Select("SELECT * "
			+ "FROM wine_delivery "
			+ "WHERE userid = #{id} "
			+ "ORDER BY state DESC ")
	public List<DeliveryVO> getDeli(String id);	
	
//	諛곗넚吏� 異붽��븯湲�
//	INSERT INTO wine_delivery VALUES ('5','�뭾�꽦鍮뚮뵫', 'ping', '01016','�꽌�슱 媛뺣턿援� 4.19濡�21湲� 4', '1212', '1212', 0);
	@Insert("INSERT INTO wine_delivery (name, userid, post, addr1, addr2, msg, status) VALUES (#{name}, #{userid}, #{post}, #{addr1}, #{addr2}, #{msg}, 0) ")
	public void addDeli(DeliveryVO vo);
	
//	�궗�슜 �쟻由쎄툑 李④컧�븯湲�
	@Update("UPDATE wine_member SET "
			+ "point = point - #{mipoint} "
			+ "WHERE userid = #{userId} ")
	public void usePoint (MemberVO vo);
	
//	寃곗젣 �쟻由쎄툑 異붽��븯湲�
	@Update("UPDATE wine_member "
	        + "SET point = point + #{plpoint} "
	        + "WHERE userid = #{userId} ")
	public void plusPoint(MemberVO vo);
	
//	荑좏룿 �궗�슜
	@Update("UPDATE my_coupon "
			+ "SET state = 0 "
			+ "WHERE mcno = #{mcno} ")
	public void useCoupon(MyCouponVO vo);
	
//	�옣諛붽뎄�땲 ���옣
	@Insert("INSERT INTO wine_cart (cno, wno, userid, account, regdate) "
	        + "VALUES (wc_cno_seq.nextval, #{wno}, #{userid}, #{account}, SYSDATE)")
	public void insertCart(Wine_CartVO vo);

	@Update("UPDATE wine_cart SET "
			+"account = account + #{account} , regdate = SYSDATE "
	  	    +"WHERE wno=#{wno}")
	public void wineCartAccountUpdate(Wine_CartVO vo);
	
	@Select("SELECT COUNT(*) FROM wine_cart "
			+"WHERE wno=#{wno}")
	public int wineCartwnoCount(int wno);
	
//	援щℓ ���옣
	@Insert("INSERT INTO wine_payment (wpno, wno, account, payment, mipoint, plpoint, wdno, mcno, psno, state, userid, regdate) "
	        + "VALUES (wp_wpno_seq.nextval, #{wno}, #{account}, #{payment}, #{mipoint}, #{plpoint}, #{wdno}, "
	        + "#{mcno}, #{psno}, 0, #{userid}, SYSDATE) ")
	public void insertPayment(Wine_PaymentVO vo);
//	援щℓ 異붽�
	@Update("UPDATE wine_payment SET "
			+ "account = account + #{account} "
			+ "WHERE wno = #{wno} ")
	public void wineBuyAccountUpdate(Wine_PaymentVO vo);
//	
	@Select("SELECT COUNT(*) FROM wine_payment "
			+ "WHERE wpno = #{wpno}")
	public int wineBuywpnoCount(int wpno);
	
//	�떊怨좏븯湲�
	@Insert("INSERT INTO wine_report (WRENO, USERID, TYPE, TNO, STATE, RID, REGDATE, CONTENT, CATEGORY) "
			+ "VALUES (wre_wreno_seq.nextval, #{userid}, #{type}, "
			+ " #{tno}, #{state}, #{rid}, SYSDATE, #{content}, #{category}) ")
	public void insertReport (Wine_ReportVO vo);
	
	@Insert("INSERT INTO winelike (lno, wno, id) "
			+ "VALUES (wl_lno_seq.nextval, #{wno}, #{id}) ")
	public LikeVO wineLikeOn (LikeVO lvo);
	
	@Delete("DELETE FROM winelike "
			+ "WHERE lno = #{lno} ")
	public LikeVO wineLikeOff (LikeVO lvo);
	
	@Select("SELECT m.username "
			+ "FROM wine_member m "
			+ "JOIN wine w "
			+ "ON m.userid = w.seller "
			+ "where w.wno = #{wno} ")
	public String selectUsername (int wno);
	
	@Select("WITH filtered_promotion_sale AS ( "
			+ "SELECT count(*) "
			+ "FROM promotion_sale "
			+ "WHERE userid = #{seller} "
			+ "AND sysdate BETWEEN startdate AND enddate "
			+ "AND state = 1 "
			+ "AND "
			+ "(type = 1 OR "
			+ "(type = 3 AND target = #{wno}) OR "
			+ "(type = 2 AND target = #{type}))) "
			+ "SELECT * "
			+ "FROM filtered_promotion_sale "
			+ "FETCH FIRST 1 ROWS ONLY ")
	public int isPro (Map map);
	
//	구매한 사람 찾기 
	@Select("SELECT (COUNT(*)) FROM wine_payment WHERE wno = #{wno} AND userid = #{userid} ")
	public int findBuyer (@Param("wno")int wno, @Param("userid")String userid);
	
//	블랙 구매 못하게
	@Select("SELECT (COUNT(*)) FROM blacklist WHERE recvid = #{userid} AND sendid = #{seller} ")
	public int blackList (@Param("userid")String userid,@Param("seller")String seller);
	
}

