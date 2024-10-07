package com.sist.service;
import com.sist.vo.*;
import java.util.*;
public interface BlackListService {
	public List<BlackListVO> blackListData(int start, int end);
	public void blackListInsert(BlackListVO vo);
}
