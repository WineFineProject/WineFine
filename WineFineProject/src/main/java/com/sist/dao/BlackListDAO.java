package com.sist.dao;
import com.sist.mapper.BlackListMapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class BlackListDAO {
	@Autowired
    private BlackListMapper mapper;
	// 블랙리스트 목록 출력
	public List<BlackListVO> blackListData(int start, int end)
	{
		return mapper.blackListData(start, end);
	}
	//블랙리스트 추가
	public void blackListInsert(BlackListVO vo)
	{
		mapper.blackListInsert(vo);
	}
}
