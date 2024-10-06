package com.sist.service;

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
}
