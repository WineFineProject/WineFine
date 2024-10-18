package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.EventDAO;
import com.sist.vo.EventVO;
import com.sist.vo.MemoVO;
import com.sist.vo.ReserveVO;

@Service
public class EventServiceImpl implements EventService{
	@Autowired
	private EventDAO eDao;
	@Override
	public List<EventVO> eventListData(int start, int end) {
		// TODO Auto-generated method stub
		return eDao.eventListData(start, end);
	}
	
	@Override
	public int eventTotalPage() {
		// TODO Auto-generated method stub
		return eDao.eventTotalPage();
	}
	
	@Override
	public EventVO eventDetailData(int weno) {
		// TODO Auto-generated method stub
		return eDao.eventDetailData(weno);
	}

	@Override
	public void reserveInsert(ReserveVO vo) {
		// TODO Auto-generated method stub
		eDao.reserveInsert(vo);
	}

	@Override
	public int reservePerson(ReserveVO vo) {
		// TODO Auto-generated method stub
		return eDao.reservePerson(vo);
	}

	@Override
	public List<ReserveVO> getReserveEvent(ReserveVO vo) {
		// TODO Auto-generated method stub
		return eDao.getReserveEvent(vo);
	}

	@Override
	public void memoInsert(MemoVO vo) {
		// TODO Auto-generated method stub
		eDao.memoInsert(vo);
	}

	@Override
	public List<MemoVO> memoListData(String userid) {
		// TODO Auto-generated method stub
		return eDao.memoListData(userid);
	}
	
	@Override
	public void memoDelete(int meno) {
		// TODO Auto-generated method stub
		eDao.memoDelete(meno);
	}
	
	@Override
	public ReserveVO getReserveDetail(int rno) {
		// TODO Auto-generated method stub
		return eDao.getReserveDetail(rno);
	}
	
	@Override
	public MemoVO memoDetailData(int meno) {
		// TODO Auto-generated method stub
		return eDao.memoDetailData(meno);
	}
  
}
