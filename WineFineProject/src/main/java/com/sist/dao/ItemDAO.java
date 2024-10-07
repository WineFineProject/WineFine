package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.ItemMapper;
import com.sist.vo.WineVO;

@Repository
public class ItemDAO {
	@Autowired
		private ItemMapper mapper;
	
	public void wineItemInsert(WineVO vo)
	{
		mapper.wineItemInsert(vo);
	}
}
