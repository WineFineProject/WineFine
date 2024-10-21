package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.sist.vo.*;
public interface LikeMapper {
	
	@Insert("INSERT INTO winelike (wno, id) VALUES (#{wno}, #{id})")
	public void addLike(@Param("wno") int wno, @Param("id") String userId);

	@Insert("INSERT INTO winelike (lno, wno, id) "
			+ "VALUES (wl_lno_seq.nextval, #{wno}, #{id}) ")
	public int wineLikeOn (@Param("wno") int wno, @Param("id") String userId);
	
	@Delete("DELETE FROM winelike "
			+ "WHERE wno = #{wno} AND id = #{id} ")
	public int wineLikeOff (@Param("wno") int wno, @Param("id") String userId);
	
	@Select("SELECT COUNT(*) FROM winelike "
			+ "WHERE wno = #{wno}")
	public int wineLikeCount(int wno);
	
	@Select("SELECT COUNT(*) FROM winelike "
			+ "WHERE wno = #{wno} AND id = #{id} ")
	public int likeCheck(@Param("wno") int wno, @Param("id") String userId);
}
