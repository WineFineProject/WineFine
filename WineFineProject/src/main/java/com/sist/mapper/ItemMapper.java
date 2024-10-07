package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.SelectKey;

import com.sist.vo.*;

public interface ItemMapper {

	// 상품 등록
	 @SelectKey(keyProperty = "wno",resultType = int.class,before = true, 
			  statement = "SELECT NVL(MAX(wno)+1,1) as wno FROM wine")
	 @Insert("INSERT INTO wine(wno,namekor,nameeng,type,price,vol,sugar,acid,body, "
	 		+ "tannin,aroma,food,maker,nation,grape,alcohol,seller,stack,poster) "
	 		+ "VALUES(#{wno},#{namekor},#{nameeng},#{type},#{price},#{vol},#{sugar}, "
	 		+ "#{acid},#{body},#{tannin},#{aroma},#{food},#{maker},#{nation},#{grape},#{alcohol}, "
	 		+ "#{seller},#{stack},#{poster})")
	 public void wineItemInsert(WineVO vo);
			 
	// 상품 수정
	
	// 상품 조회
	
	// 상품 승인 대기
	
}
