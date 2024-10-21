package com.sist.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface AdminService {
	public List<Integer> visitWeeks();
	public int visitMax();
	public int noneCoupon();
	public int noneSale();
	public int noneBanner();
	public int noneItem();
	public int noneAnswer();
	public int nonePayment();
}
