package com.sist.service;
import java.util.*;
import com.sist.vo.*;
public interface EventService {
	public List<EventVO> eventListData(int start, int end);
	public int eventTotalPage();
	public EventVO eventDetailData(int weno);
	public void reserveInsert(ReserveVO vo);
	public int reservePerson(ReserveVO vo);
	public List<ReserveVO> getReserveEvent(ReserveVO vo);
	public ReserveVO getReserveDetail(int rno);
	public void memoInsert(MemoVO vo);
	public List<MemoVO> memoListData(String userid);
	public void memoDelete(int meno);
	public MemoVO memoDetailData(int meno);
}
