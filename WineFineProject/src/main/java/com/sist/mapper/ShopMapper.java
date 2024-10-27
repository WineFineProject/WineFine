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
//	���씤 珥� 媛��닔
	@Select("SELECT COUNT(*) "
			+ "FROM wine")
	public int wineCount();
//	占쏙옙占쎌뵥 �뵳�딅뮞占쎈뱜
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
//	�룯占� 占쎈읂占쎌뵠筌욑옙
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
	
//	鈺곌퀬�돳占쎈땾
	@Update("UPDATE wine SET "
			+ "hit=hit+1 "
			+ "WHERE wno=#{wno} ")
	public void hitIncrement(int wno);
	
//  占쎈７占쎈즲筌륅옙
	@Select("SELECT namekor FROM grape WHERE (SELECT grape FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> grapeName(int wno);

//	占쎄돌占쎌뵬筌륅옙
	@Select("SELECT namekor FROM nation WHERE (SELECT nation FROM wine WHERE wno = #{wno}) LIKE '%'||no||'%' ")
	public List<String> nationName(int wno); 

	
//	占쏙옙占쎌뵥 占쎄맒占쎄쉭癰귣떯由�
	@Select("SELECT w.wno, w.vol, w.type, w.tannin, w.sugar, w.state, w.stack, "
	        + "w.seller, w.score, w.regdate, w.price, w.poster, w.nation, "
	        + "w.namekor, w.nameeng, w.maker, w.likecount, w.hit, w.grape, "
	        + "w.food, w.body, w.aroma, w.alcohol, w.acid, w.nbno, "
	        + "m.namekor AS makerkor, m.nameeng AS makereng "
	        + "FROM wine w "
	        + "LEFT JOIN maker m ON TO_NUMBER(w.maker) = m.no "
	        + "WHERE w.wno = #{wno}")
	public WineVO wineDetailData(int wno);

//	占쏙옙占쎌뵥�뤃�됤꼻 占쎌젟癰귨옙
	@Select("SELECT wno, namekor, TO_NUMBER(REPLACE(REPLACE(price, '원', ''), ',', '')) AS price, poster, seller, type "
	        + "FROM wine "
	        + "WHERE wno = #{wno}")
	public WineVO winebuy(int wno);

	
//	占쎄텢占쎌뒠 揶쏉옙占쎈뮟 �뜎醫뤿？ 揶쏉옙占쎌죬占쎌궎疫뀐옙
	@Select("SELECT mcno, title, discount, TO_CHAR(enddate,'YYYY-MM-DD') as endDay "
	        + "FROM my_coupon  "
	        + "WHERE recvid = #{id} "
	        + "AND state = 0 "
	        + "AND SYSDATE BETWEEN startdate AND enddate ")
	public List<MyCouponVO> selectCoupon(String id);
	
//	占쎈늄嚥≪뮆�걟占쎈�� 占쎄쉭占쎌뵬
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
	
//	揶쏆늿占� 占쎄문占쎄텦占쎌쁽
	@Select("SELECT wno, type, namekor, price, vol, poster, hit "
	        + "FROM (SELECT wno, type, namekor, price, vol, poster, hit "
	        + "      FROM wine "
	        + "      WHERE (SELECT maker FROM wine WHERE wno = #{wno}) = maker "
	        + "      ORDER BY hit DESC) "
	        + "WHERE ROWNUM <= 5")
	public List<WineVO> otherWine_maker(int wno);
	
//	揶쏆늿占� 占쎈솇筌띲끉�쁽 
	@Select("SELECT wno, type, namekor, price, vol, poster, hit "
	        + "FROM (SELECT wno, type, namekor, price, vol, poster, hit "
	        + "      FROM wine "
	        + "      WHERE (SELECT seller FROM wine WHERE wno = #{wno}) = seller "
	        + "      ORDER BY hit DESC) "
	        + "WHERE ROWNUM <= 5")
	public List<WineVO> otherWine_seller(int wno);

//	占쎈７占쎌뵥占쎈뱜 揶쏉옙占쎌죬占쎌궎疫뀐옙
	@Select("SELECT point "
			+ "FROM wine_member "
			+ "WHERE userid = #{id}")
	public String getPoint(String id);
	
//	占쎌돳占쎌뜚占쎈쾻疫뀐옙 揶쏉옙占쎌죬占쎌궎疫뀐옙
	@Select("SELECT grade "
			+ "FROM wine_member "
			+ "WHERE userid = #{id}")
	public String getgrade(String id);
	
//	獄쏄퀣�꽊筌욑옙 
	@Select("SELECT * "
			+ "FROM wine_delivery "
			+ "WHERE userid = #{id} "
			+ "ORDER BY state DESC ")
	public List<DeliveryVO> getDeli(String id);	
	
//	獄쏄퀣�꽊筌욑옙 �빊遺쏙옙占쎈릭疫뀐옙
//	INSERT INTO wine_delivery VALUES ('5','占쎈�억옙苑��뜮�슢逾�', 'ping', '01016','占쎄퐣占쎌뒻 揶쏅베�꽴�뤃占� 4.19嚥∽옙21疫뀐옙 4', '1212', '1212', 0);
	@Insert("INSERT INTO wine_delivery (name, userid, post, addr1, addr2, msg, status) VALUES (#{name}, #{userid}, #{post}, #{addr1}, #{addr2}, #{msg}, 0) ")
	public void addDeli(DeliveryVO vo);
	
//	占쎄텢占쎌뒠 占쎌읅�뵳�럡�닊 筌△몿而㏆옙釉�疫뀐옙
	@Update("UPDATE wine_member SET "
			+ "point = point - #{mipoint} "
			+ "WHERE userid = #{userId} ")
	public void usePoint (MemberVO vo);
	
//	野껉퀣�젫 占쎌읅�뵳�럡�닊 �빊遺쏙옙占쎈릭疫뀐옙
	@Update("UPDATE wine_member "
	        + "SET point = point + #{plpoint} "
	        + "WHERE userid = #{userId} ")
	public void plusPoint(MemberVO vo);
	
//	�뜎醫뤿？ 占쎄텢占쎌뒠
	@Update("UPDATE my_coupon "
			+ "SET state = 0 "
			+ "WHERE mcno = #{mcno} ")
	public void useCoupon(MyCouponVO vo);
	
//	占쎌삢獄쏅떽�럡占쎈빍 占쏙옙占쎌삢
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
	
//	�뤃�됤꼻 占쏙옙占쎌삢
	@Insert("INSERT INTO wine_payment (wpno, wno, account, payment, mipoint, plpoint, wdno, mcno, psno, state, userid, regdate) "
	        + "VALUES (wp_wpno_seq.nextval, #{wno}, #{account}, #{payment}, #{mipoint}, #{plpoint}, #{wdno}, "
	        + "#{mcno}, #{psno}, 0, #{userid}, SYSDATE) ")
	public void insertPayment(Wine_PaymentVO vo);
//	�뤃�됤꼻 �빊遺쏙옙
	@Update("UPDATE wine_payment SET "
			+ "account = account + #{account} "
			+ "WHERE wno = #{wno} ")
	public void wineBuyAccountUpdate(Wine_PaymentVO vo);
//	
	@Select("SELECT COUNT(*) FROM wine_payment "
			+ "WHERE wpno = #{wpno}")
	public int wineBuywpnoCount(int wpno);
	
//	占쎈뻿�⑥쥚釉�疫뀐옙
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
	
//	援щℓ�븳 �궗�엺 李얘린 
	@Select("SELECT (COUNT(*)) FROM wine_payment WHERE wno = #{wno} AND userid = #{userid} ")
	public int findBuyer (@Param("wno")int wno, @Param("userid")String userid);
	
//	釉붾옓 援щℓ 紐삵븯寃�
	@Select("SELECT (COUNT(*)) FROM blacklist WHERE recvid = #{userid} AND sendid = #{seller} ")
	public int blackList (@Param("userid")String userid,@Param("seller")String seller);
	
}

