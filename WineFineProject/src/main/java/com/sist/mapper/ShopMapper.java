package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface ShopMapper {
	/*
	WNO NAMEKOR NAMEENG TYPE PRICE VOL SUGAR ACID BODY TANNIN AROMA FOOD
	MAKER NATION GRAPE ALCOHOL SELLER STACK SCORE HIT REGDATE LIKECOUNT POSTER STATE
	 */
//	���씤 由ъ뒪�듃
	@Select("SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, rownum as num "
	        + "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster "
	        + "FROM wine ORDER BY wno ASC, state DESC)) "
	        + "WHERE num BETWEEN #{start} AND #{end}")
	public List<WineVO> wineListData(@Param("start")int start,@Param("end")int end);
//	���씤 珥� �럹�씠吏�
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
	
//	상세보기
	@Update("UPDATE wine SET "
			+ "hit=hit+1 "
			+ "WHERE wno=#{wno} ")
	public void hitIncrement(int wno);
	
	// 포도명, 나라명 가져오기
	@Select("SELECT DISTINCT n.namekor AS nationname, g.namekor AS grapename "
	        + "FROM wine w "
	        + "JOIN nation n ON ',' || w.nation || ',' LIKE '%,' || n.no || ',%' "
	        + "JOIN grape g ON ',' || w.grape || ',' LIKE '%,' || g.no || ',%' "
	        + "WHERE w.wno = #{wno} ")
	public List<WineVO> grapeName(int wno); // Map으로 반환하도록 수정


	@Select("SELECT * FROM wine "
			+ "WHERE wno=#{wno} ")
	public WineVO wineDetailData(int wno);
}
