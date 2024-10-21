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
	@Select("SELECT c.cno,c.wno,c.price as cart_price,c.count,c.id " +
            "w.namekor,w.poster,w.price as wine_price " +
            "FROM cart c JOIN wine w ON c.wno = w.wno " +
            "WHERE c.id = #{id}")
    @Results({
        @Result(property = "cno", column = "cno"),
        @Result(property = "wno", column = "wno"),
        @Result(property = "price", column = "cart_price"),
        @Result(property = "count", column = "count"),
        @Result(property = "id", column = "id"),
        @Result(property = "wine.namekor", column = "namekor"),
        @Result(property = "wine.poster", column = "poster"),
        @Result(property = "wine.price", column = "wine_price")
    })
	public List<CartVO> cartListData(@Param("id") String id);
	
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
