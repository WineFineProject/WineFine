package com.sist.service;
import com.sist.vo.*;
import java.util.*;
public interface BlackListService {
	public void blackListInsert(BlackListVO vo);
	public List<MemberVO> blackList(Map map);
    public int blackListCount(Map map);
    public void blackListDelete(BlackListVO vo);
}
