package com.sist.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

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
	 @Select("SELECT wno, namekor, price, stack, seller, hit, type, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, state, poster, nbno, num "
			 +"FROM (SELECT wno, namekor, price, stack, seller, hit, type, regdate, state, poster, nbno, rownum as num "
			 +"FROM (SELECT wno, namekor, price, stack, seller, hit, type, regdate, state, poster, nbno "
	 		 +"FROM wine WHERE seller LIKE '%'||#{seller}||'%' AND state <=3 "
	 		 + "ORDER BY CASE WHEN #{sortOrder} = 'recent' THEN regdate END DESC,"
	 		 + "CASE WHEN #{sortOrder} = 'popular' THEN hit END DESC)) "
	 		 + "WHERE num BETWEEN #{start} AND #{end} ")
	 public List<WineVO> sellerItemListData(@Param("seller") String seller, @Param("start") int start, @Param("end") int end, @Param("sortOrder") String sortOrder);
	 
	 // 판매자 별 와인 총 개수 
	 @Select("SELECT COUNT(*) FROM wine WHERE seller LIKE '%'||#{seller}||'%' AND state <=3 ")
	 public int sellerItemCount(@Param("seller") String seller);
	 
	 // 개별 상품 삭제
	 @Delete("DELETE FROM wine WHERE wno = #{wno}")
	 public void itemDelete(@Param("wno") int wno);
	 
	 // 체크된 상품 삭제
	 public void deleteItems(@Param("list") List<Integer> wnos);
	 
	 // 상품 일괄 수정 
	 public void updateItem(WineVO vo);
	 
	//판매자 공지 목록
		@Select("SELECT nbno, subject, type, target, userId "
				+"FROM noticeboard WHERE userId = #{id}")
		public List<NoticeBoardVO> sellersNotice(String id);
	 	
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
	public List<String> getGrapeNames(@Param("grapeNumbers") List<String> grapeNumbers);

	// 상품 내용 업데이트
	@Update("UPDATE wine SET namekor=#{namekor}, nameeng=#{nameeng}, type=#{type}, price=#{price}, "
	        + "vol=#{vol}, sugar=#{sugar}, acid=#{acid}, body=#{body}, tannin=#{tannin}, "
	        + "aroma=#{aroma}, food=#{food}, maker=#{maker}, nation=#{nation}, grape=#{grape}, "
	        + "alcohol=#{alcohol}, seller=#{seller}, stack=#{stack}, poster=#{poster} "
	        + "WHERE wno=#{wno}")
	public void wineItemUpdate(WineVO vo);
	
	// 상품 승인 대기
	// 상품 승인 대기 / 반려 목록
	@Select("SELECT wno, namekor, type, maker, seller, price, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, state "
			+ "FROM wine WHERE seller = #{id} AND state = #{state} ORDER BY wno DESC")
	public List<WineVO> approvalCheckList(@Param("id") String id, @Param("state") int state);
	// 상품 승인 대기 / 반려 개수
	@Select("SELECT COUNT(*) FROM wine WHERE seller = #{id} AND state = #{state}")
	public int approvalCheckCount(@Param("id") String id, @Param("state") int state);
	
	// 판매자 샵
	// 판매자 정보 (로고, 이름)
	@Select("SELECT userName, photo FROM wine_member WHERE userId = #{id} ")
	public MemberVO sellerInfoData(String id);
	
	//판매자 공지 목록
	@Select("SELECT nbno, subject, type, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, nickname, content, target "
			+"FROM noticeboard WHERE userId = #{id} ")
	public List<NoticeBoardVO> sellerNoticeList(String id);
	
	// 특정 와인 공지 와인 이름 
	@Select("SELECT namekor FROM wine WHERE wno = #{target} ")
	public String noticeWineName(@Param("target") int target);
	
	//판매자 상품 목록
	@Select("SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, state, num "
			+ "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, state, rownum as num "
			+ "FROM (SELECT wno, namekor, nameeng, seller, type, price, score, likecount, poster, state "
	        + "FROM wine WHERE seller = #{id} AND state = 1 ORDER BY wno DESC)) "
	        + "WHERE num <= #{end} ")
	public List<WineVO> sellerWineList(@Param("id") String id, @Param("end") int end);
	
	//판매자 주문 조회
	public List<Wine_PaymentVO> orderList(Map map);
	
	// 판매자 주문 개수
	public Map<String, BigDecimal> getOrderCounts(@Param("userId")String userId);
	
	// 판매자 주문 취소
	@Update("UPDATE wine_payment SET state = 8 "
	        + "WHERE wpno=#{wpno}")
	public void ordercancelUpdate(int wpno);
	
	// 판매자 반품 승인
	@Update("UPDATE wine_payment SET state = 9 "
	        + "WHERE wpno=#{wpno}")
	public void ordereturnUpdate(int wpno);
}
