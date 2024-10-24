package com.sist.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.sist.vo.AccVO;

public interface AdminService {
	public List<Integer> visitWeeks();
	public int visitMax();
	public int noneCoupon();
	public int noneSale();
	public int noneBanner();
	public int noneItem();
	public int noneAnswer();
	public int nonePayment();
	public List<AccVO> accList();
	public void accUpdate(int state, int acno);
}
