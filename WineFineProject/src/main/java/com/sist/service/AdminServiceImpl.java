package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.AdminDAO;
import com.sist.vo.AccVO;
@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDAO dao;
	
	@Override
	public int visitMax() {
		return dao.visitMax();
	}
	@Override
	public List<Integer> visitWeeks() {
		return dao.visitWeeks();
	}
	@Override
	public int noneCoupon() {
		return dao.noneCoupon();
	}
	@Override
	public int noneSale() {
		return dao.noneSale();
	}
	@Override
	public int noneBanner() {
		return dao.noneBanner();
	}
	@Override
	public int noneItem() {
		return dao.noneItem();
	}
	@Override
	public int noneAnswer() {
		return dao.noneAnswer();
	}
	@Override
	public int nonePayment() {
		return dao.nonePayment();
	}
	@Override
	public List<AccVO> accList() {
		// TODO Auto-generated method stub
		return dao.accList();
	}
	@Override
	public void accUpdate(int state, int acno) {
		// TODO Auto-generated method stub
		dao.accUpdate(state, acno);
	}
}
