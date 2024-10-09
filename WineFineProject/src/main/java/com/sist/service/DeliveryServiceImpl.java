package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.DeliveryDAO;
import com.sist.vo.DeliveryVO;

@Service
public class DeliveryServiceImpl implements DeliveryService{
	@Autowired
	private DeliveryDAO dao;
	
	@Override
	public List<DeliveryVO> myDeliveryList(String userId) {
		return dao.myDeliveryList(userId);
	}
	
	@Override
	public void myDeliveryDelete(int wdno) {
		dao.myDeliveryDelete(wdno);
	}
	
	@Override
	public void myDeliveryInsert(DeliveryVO vo) {
		dao.myDeliveryInsert(vo);
	}
	
	@Override
	public void myDeliveryStateUpdate(String userId, int wdno) {
		dao.myDeliveryStateUpdate(userId, wdno);
	}
}
