package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.NoticeMapper;
import com.sist.vo.NoticeVO;

@Repository
public class NoticeDAO {
	@Autowired
	private NoticeMapper mapper;
	
	public void noticeInsert(NoticeVO vo) {
		mapper.noticeInsert(vo);
	}
	
	public List<NoticeVO> noticeNewListData(String id){
		return mapper.noticeNewListData(id);
	}
	
	public int noticeNewCount(String id) {
		return mapper.noticeNewCount(id);
	}
	
	public List<NoticeVO> noticeOldListData(String id){
		return mapper.noticeOldListData(id);
	}
	
	public void noticeStateUpdate(int nno) {
		mapper.noticeStateUpdate(nno);
	}
}
