package com.sist.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

import java.util.*;

public interface CartMapper {
	// 추가
	@Insert("INSERT INTO cart(cno,id,wno,price,count) "
			+ "VALUES(cart_cno_seq.NEXTVAL,#{id},#{wno},#{price},#{count})")
	public String addCart(CartVO vo);
	
	// 목록
    @Results({
        @Result(property = "wvo.namekor", column = "namekor"),
        @Result(property = "wvo.poster", column = "poster"),
        @Result(property = "wvo.price", column = "price"),
        @Result(property = "wvo.mvo.nickName", column = "nickname")
    })
  @Select("SELECT cno, wno, userid, account, TO_CHAR(regdate, 'YYYY-MM-DD') as dbday, namekor, poster, price, nickname, num "
  		+ "FROM (SELECT cno, wno, userid, account, regdate, namekor, poster, price, nickname, rownum as num "
  		+ "FROM (SELECT c.cno, c.wno, c.userid, c.account, c.regdate, w.namekor, w.poster, w.price, m.nickname "
  		+ "FROM wine_cart c JOIN wine w ON c.wno=w.wno "
  		+ "JOIN wine_member m ON c.userId=m.userid "
  		+ "WHERE c.userid=#{userid} "
  		+ "ORDER BY c.regdate DESC)) "
  		+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<CartVO> cartListData(Map map);
	
  @Select("SELECT CEIL(COUNT(*)/10.0) FROM wine_cart WHERE userid=#{userid}")
  public int cartTotalPage(Map map);
    
	@Select("SELECT w.wno,w.namekor,w.poster,w.price,"
			+ "c.wno"
			+ "FROM wine w JOIN cart c ON w.wno=c.cno "
			+ "WHERE wno=#{wno},cno=#{cno}")
	public WineVO getWine(@Param("wno") int wno,@Param("cno") int cno);
	
	
	// 수정(개수 변경)
	@Update("UPDATE cart SET count=#{count} "
			+ "WHERE cno=#{cno} AND id=#{id}")
	public int updateCart(@Param("cno") int cno,@Param("count") int count,@Param("id") String id);
	
	// 삭제
	@Delete("DELETE FROM cart "
			+ "WHERE cno=#{cno}")
	public int delCart(@Param("cno") int cno);
	
	// 카트 개수
	@Select("SELECT COUNT(*) FROM wine_cart WHERE userid=#{userId}")
	public int myCartCount(String userId);
}
