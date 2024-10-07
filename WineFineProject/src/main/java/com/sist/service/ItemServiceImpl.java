package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.WineVO;
import com.sist.dao.*;

@Service
public class ItemServiceImpl implements ItemService{

	@Autowired
		private ItemDAO dao;
	
	@Override
	public void wineItemInsert(WineVO vo) {
		// TODO Auto-generated method stub
		dao.wineItemInsert(vo);
	}

}
