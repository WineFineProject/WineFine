package com.sist.dao;
import com.sist.mapper.BlackListMapper;
import com.sist.vo.*;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class BlackListDAO {
	@Autowired
    private BlackListMapper mapper;
	//블랙리스트 추가
	public void blackListInsert(BlackListVO vo)
	{
		mapper.blackListInsert(vo);
	}
	// 블랙리스트 목록
	public List<MemberVO> blackList(Map map)
	{
		return mapper.blackList(map);
	}
	// 블랙리스트 페이징
	public int blackListCount(Map map)
	{
		return mapper.blackListCount(map);
	}
	// 블랙리스트 삭제
	public void blackListDelete(BlackListVO vo)
	{
		mapper.blackListDelete(vo);
	}
	// 블랙리스트 중복확인
	public int blackListCheck(Map map)
	{
		return mapper.blackListCheck(map);
	}
}
