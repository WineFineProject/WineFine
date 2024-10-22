package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.WineReturnMapper;
import com.sist.vo.WineReturnVO;

@Repository
public class WineReturnDAO {
	@Autowired
	private WineReturnMapper mapper;
	
	public void returnRequestInsert(WineReturnVO vo) {
		mapper.returnRequestInsert(vo);
	}
}
