package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.ShopDAO;

@Service
public class ShopServiceImpl implements ShopService{
	private ShopDAO sdao;
	@Autowired
	public ShopServiceImpl(ShopDAO sdao) {
		this.sdao = sdao;
	}
}
