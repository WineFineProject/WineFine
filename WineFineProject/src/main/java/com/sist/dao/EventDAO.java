package com.sist.dao;

import java.util.List;

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
}
