package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.NoticeBoardDAO;
import com.sist.vo.NoticeBoardVO;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService{
	@Autowired
	private NoticeBoardDAO dao;
	
	@Override
	public void noticeBoardInsert(NoticeBoardVO vo) {
		dao.noticeBoardInsert(vo);
	}
	
	@Override
	public List<NoticeBoardVO> sellerNoticeList(Map map) {
		return dao.sellerNoticeList(map);
	}
	
	@Override
	public int sellerNoticeTotalPage(Map map) {
		return dao.sellerNoticeTotalPage(map);
	}
	
	@Override
	public NoticeBoardVO noticeDetail(int nbno) {
		return dao.noticeDetail(nbno);
	}
	
	@Override
	public void noticeBoardUpdate(NoticeBoardVO vo) {
		dao.noticeBoardUpdate(vo);
	}
	
	@Override
	public NoticeBoardVO noticeDetailData(int nbno) {
		return dao.noticeDetailData(nbno);
	}
}
