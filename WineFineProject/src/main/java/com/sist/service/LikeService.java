package com.sist.service;
import java.util.*;

import org.apache.ibatis.annotations.Param;

import com.sist.vo.*;

public interface LikeService {
	public int wineLikeOn (int wno, String userId);
	public int wineLikeOff (int wno,String userId);
	public int wineLikeCount(int wno);
	public int likeCheck(int wno, String userId);
}
