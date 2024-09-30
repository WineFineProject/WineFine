package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.ShopDAO;
import com.sist.vo.WineVO;

@Service
public class ShopServiceImpl implements ShopService{
	private ShopDAO sdao;
	@Autowired
	public ShopServiceImpl(ShopDAO sdao) {
		this.sdao = sdao;
	}
	
	@Override
	public List<WineVO> wineListData(int start, int end) {
		// TODO Auto-generated method stub
		return sdao.wineListData(start, end);
	}

	@Override
	public int shopTotalPage() {
		// TODO Auto-generated method stub
		return sdao.shopTotalPage();
	}
}
