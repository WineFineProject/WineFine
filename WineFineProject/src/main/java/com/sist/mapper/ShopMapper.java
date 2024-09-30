package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface ShopMapper {
	/*
	WNO NAMEKOR NAMEENG TYPE PRICE VOL SUGAR ACID BODY TANNIN AROMA FOOD
	MAKER NATION GRAPE ALCOHOL SELLER STACK SCORE HIT REGDATE LIKECOUNT POSTER STATE
	 */
//	와인 리스트
	@Select("SELECT wno,namekor,nameeng,seller,type,price,score,likecount,poster,num "
			+ "FROM (SELECT wno,namekor,nameeng,seller,type,price,score,likecount,poster,rownum as num "
			+ "FROM (SELECT wno,namekor,nameeng,seller,type,price,score,likecount,poster "
			+ "FROM wine ORDER BY fno ASC, ORDER BY state DESC )) "
			+ "WHERE num BETWEEN #{start} AND #{end} ")
	public List<WineVO> wineListData(@Param("start")int start,@Param("end")int end);
//	와인 총 페이지
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int shopTotalPage();
}
