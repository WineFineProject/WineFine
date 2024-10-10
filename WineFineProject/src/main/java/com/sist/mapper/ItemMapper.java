package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
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
	
	// 생산자 리스트 검색
	 @Select("SELECT no, namekor FROM maker WHERE namekor LIKE '%'||#{find}||'%'")
	 public List<MakerVO> makerFindListData(@Param("find") String find);
	// 품종 리스트 검색
	 @Select("SELECT no, namekor FROM grape WHERE namekor LIKE '%'||#{find}||'%'")
	 public List<GrapeVO> grapeFindListData(@Param("find") String find);
	 
	// 지역 리스트 검색
	// 나라 리스트 
	 @Select("SELECT no, namekor, part FROM itemnation WHERE part=1")
	 public List<ItemNationVO> nation1FindListData();
	// 지역1 리스트 
	 @Select("SELECT no, namekor, part, area FROM itemnation WHERE area=#{areanum} AND part=2")
	 public List<ItemNationVO> nation2FindListData(@Param("areanum") int areanum);
	// 지역2 리스트  
	 @Select("SELECT no, namekor, part, area FROM itemnation WHERE area=#{areanum} AND part=3")
	 public List<ItemNationVO> nation3FindListData(@Param("areanum") int areanum);
	// 지역3 리스트 
	 @Select("SELECT no, namekor, part, area FROM itemnation WHERE area=#{areanum} AND part=4")
	 public List<ItemNationVO> nation4FindListData(@Param("areanum") int areanum);
	 
	// 상품 수정
	
	// 상품 조회
	
	// 상품 승인 대기
	
}
