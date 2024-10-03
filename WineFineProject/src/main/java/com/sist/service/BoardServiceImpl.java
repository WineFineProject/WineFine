package com.sist.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.*;
import com.sist.dao.*;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
		private BoardDAO dao;
	@Override
	public List<BoardVO> boardListData(int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardListData(start, end);
	}

	@Override
	public List<BoardVO> boardTypeListData(int cno, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardTypeListData(cno, start, end);
	}
	
	@Override
	public int boardTotalPage() {
		// TODO Auto-generated method stub
		return dao.boardTotalPage();
	}
	
	@Override
	public String boardNickname(String id) {
		// TODO Auto-generated method stub
		return dao.boardNickname(id);
	}
	@Override
	public void boardInsert(BoardVO vo) {
		// TODO Auto-generated method stub
		dao.boardInsert(vo);
	}

	@Override
	public BoardVO boardDetailData(int bno) {
		// TODO Auto-generated method stub
		return dao.boardDetailData(bno);
	}

	@Override
	public BoardVO boardUpdateData(int bno) {
		// TODO Auto-generated method stub
		return dao.boardUpdateData(bno);
	}

	@Override
	public String boardUpdate(BoardVO vo) {
		// TODO Auto-generated method stub
		return dao.boardUpdate(vo);
	}

	@Override
	public void boardDelete(int bno) {
		// TODO Auto-generated method stub
		dao.boardDelete(bno);
	}

	@Override
	public BoardVO boardFileInfoData(int bno) {
		// TODO Auto-generated method stub
		return dao.boardFileInfoData(bno);
	}

	
	
}
