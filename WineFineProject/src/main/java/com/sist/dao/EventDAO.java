package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sist.vo.*;
import com.sist.mapper.*;
@Repository
public class EventDAO {
	@Autowired
	private EventMapper mapper;
	@Autowired
	private ReserveMapper rmapper;
	public List<EventVO> eventListData(int start, int end)
	{
		return mapper.eventListData(start, end);
	}
	
	public int eventTotalPage()
	{
		return mapper.eventTotalPage();
	}
	
	public EventVO eventDetailData(int weno)
	{
		return mapper.eventDetailData(weno);
	}
	
	public void reserveInsert(ReserveVO vo)
	{
		rmapper.reserveInsert(vo);
	}
	
	public int reservePerson(ReserveVO vo)
	{
		return rmapper.reservePerson(vo);
	}
	
	public List<ReserveVO> getReserveEvent(ReserveVO vo)
	{
		return rmapper.getReserveEvent(vo);
	}
	
	public ReserveVO getReserveDetail(int rno)
	{
		return rmapper.getReserveDetail(rno);
	}
	public void memoInsert(MemoVO vo)
	{
		rmapper.memoInsert(vo);
	}
	
	public List<MemoVO> memoListData(String userid)
	{
		return rmapper.memoListData(userid);
	}
	
	public MemoVO memoDetailData(int meno)
	{
		return rmapper.memoDetailData(meno);
	}

	public void memoDelete(int meno)
	{
		rmapper.memoDelete(meno);
	}
	
	public List<ReserveVO> getMyReserveEvent(Map map){
		return rmapper.getMyReserveEvent(map);
	}
	
	public int myReserveTotalPage(Map map) {
		return rmapper.myReserveTotalPage(map);
	}
	
	public void deleteReserve(int rno) {
		rmapper.deleteReserve(rno);
	}
}
