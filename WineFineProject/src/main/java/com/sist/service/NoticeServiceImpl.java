package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.NoticeDAO;
import com.sist.dao.WineReturnDAO;
import com.sist.vo.NoticeBoardVO;
import com.sist.vo.NoticeVO;
import com.sist.vo.WineReturnVO;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private NoticeDAO dao;
	@Autowired
	private WineReturnDAO wDao;
	@Override
	public void noticeInsert(NoticeVO vo) {
		dao.noticeInsert(vo);
	}
	
	@Override
	public List<NoticeVO> noticeNewListData(String id) {
		return dao.noticeNewListData(id);
	}
	
	@Override
	public int noticeNewCount(String id) {
		return dao.noticeNewCount(id);
	}
	
	@Override
	public List<NoticeVO> noticeOldListData(String id) {
		return dao.noticeOldListData(id);
	}
	
	@Override
	public void noticeStateUpdate(int nno) {
		dao.noticeStateUpdate(nno);
	}
	@Override
	public void returnRequestInsert(WineReturnVO vo) {
		wDao.returnRequestInsert(vo);
	}
}
