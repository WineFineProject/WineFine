package com.sist.service;
import java.util.*;
import com.sist.vo.*;
public interface EventService {
	public List<EventVO> eventListData(int start, int end);
	public int eventTotalPage();
	public EventVO eventDetailData(int weno);
	public void reserveInsert(ReserveVO vo);
	public int reservePerson(ReserveVO vo);
}
