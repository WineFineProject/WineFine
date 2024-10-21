package com.sist.dao;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.LikeMapper;
import com.sist.vo.LikeVO;

@Repository
public class LikeDAO {
	@Autowired
	private LikeMapper mapper;
	
	public int wineLikeOn (int wno,String userId) {
		return mapper.wineLikeOn(wno, userId);
	}
	public int wineLikeOff (int wno, String userId) {
		return mapper.wineLikeOff(wno, userId);
	}	
	public int wineLikeCount(int wno) {
		return mapper.wineLikeCount(wno);
	}	
	public int likeCheck(int wno, String userId) {
		return mapper.likeCheck(wno, userId);
	}
}
