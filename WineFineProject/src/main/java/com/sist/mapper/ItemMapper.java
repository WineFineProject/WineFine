package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
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
	 
     // 상품 조회
	 // 판매자 별 와인상품 리스트 
	 @Select("SELECT wno, namekor, price, stack, seller, hit, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, state, poster, num "
			 +"FROM (SELECT wno, namekor, price, stack, seller, hit, regdate, state, poster, rownum as num "
			 +"FROM (SELECT wno, namekor, price, stack, seller, hit, regdate, state, poster "
	 		 +"FROM wine WHERE seller LIKE '%'||#{seller}||'%' ORDER BY wno DESC)) "
	 		 + "WHERE num BETWEEN #{start} AND #{end} ")
	 public List<WineVO> sellerItemListData(@Param("seller") String seller, @Param("start") int start, @Param("end") int end);
	 
	 // 판매자 별 와인 총 개수 
	 @Select("SELECT COUNT(*) FROM wine WHERE seller LIKE '%'||#{seller}||'%' ")
	 public int sellerItemCount(@Param("seller") String seller);
	 
	 // 개별 상품 삭제
	 @Delete("DELETE FROM wine WHERE wno = #{wno}")
	 public void itemDelete(@Param("wno") int wno);
	 
	 // 체크된 상품 삭제
	 public void deleteItems(@Param("list") List<Integer> wnos);
	 
	 // 상품 일괄 수정 
	 public void updateItem(WineVO vo);
	 
	 // 판매자 공지 리스트 (번호, 제목)
	  
	// 상품 수정 
	// 변경 전 상품 데이터
	@Select("SELECT wno,namekor,nameeng,type,price,vol,sugar,acid,body, "
			+"tannin,aroma,food,maker,nation,grape,alcohol,seller,stack,poster "
			+"FROM wine WHERE wno = #{wno}")
	public WineVO wineItemData(int wno);
	// 생산자 검색 
	@Select("SELECT namekor FROM maker WHERE no = #{makernum}")
	public String getMakerkor(@Param("makernum") int maker);
	
	// 품종 검색
	@Select("SELECT namekor FROM grape WHERE no IN (#{grapeNumbers})")
	public List<String> getGrapeNames(@Param("grapeNumbers") String grapeNumbers);
	
	// 나라 검색
	@Select("SELECT namekor FROM nation WHERE no IN (#{nationNumbers})")
	public List<String> getNationNames(@Param("nationNumbers") String nationNumbers);
	
	// 상품 내용 업데이트
	
	// 상품 승인 대기
	
}
