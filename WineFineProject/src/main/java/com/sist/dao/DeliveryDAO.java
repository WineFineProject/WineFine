package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.DeliveryMapper;
import com.sist.vo.*;
@Repository
public class DeliveryDAO {
	@Autowired
	private DeliveryMapper mapper;
	
	public List<DeliveryVO> myDeliveryList(String userId){
		return mapper.myDeliveryList(userId);
	}
	
	public void myDeliveryInsert(DeliveryVO vo) {
		mapper.deliveryInsert(vo);
		if(vo.getState()==1) {
			mapper.deliveryStateUpdate1(vo.getUserId());
			mapper.deliveryStateUpdate2(vo.getUserId());
		}
	}
	public void myDeliveryStateUpdate(String userId, int wdno) {
		mapper.deliveryStateUpdate1(userId);
		mapper.deliveryStateUpdate3(wdno);
	}
	
	public void myDeliveryDelete(int wdno) {
		mapper.deliveryStateDelete(wdno);
	}
}
