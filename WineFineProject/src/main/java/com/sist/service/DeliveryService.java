package com.sist.service;

import java.util.List;

import com.sist.vo.DeliveryVO;

public interface DeliveryService {
	public List<DeliveryVO> myDeliveryList(String userId);
	public void myDeliveryInsert(DeliveryVO vo);
	public void myDeliveryDelete(int wdno);
	public void myDeliveryStateUpdate(String userId, int wdno);
}
