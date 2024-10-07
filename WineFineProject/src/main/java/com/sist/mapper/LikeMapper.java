package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.sist.vo.*;
public interface LikeMapper {
	
	@Insert("INSERT INTO winelike (wno, id) VALUES (#{wno}, #{id})")
	public void addLike(@Param("wno") int wno, @Param("id") String userId);

}
