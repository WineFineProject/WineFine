package com.sist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.AdminMapper;

@Repository
public class AdminDAO {
	@Autowired
	private AdminMapper mapper;
	
	public List<Integer> visitWeeks(){
		return mapper.visitWeeks();
	}
	
	public int visitMax() {
		return mapper.visitMax();
	}
	
	public int noneCoupon() {
		return mapper.noneCoupon();
	}
	public int noneSale() {
		return mapper.noneSale();
	}
	public int noneBanner() {
		return mapper.noneBanner();
	}
	public int noneItem() {
		return mapper.noneItem();
	}
	public int noneAnswer() {
		return mapper.noneAnswer();
	}
	public int nonePayment() {
		return mapper.nonePayment();
	}
}
