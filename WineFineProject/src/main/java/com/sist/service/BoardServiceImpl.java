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
	public String boardDelete(int bno) {
		// TODO Auto-generated method stub
		return dao.boardDelete(bno);
	}

	@Override
	public BoardVO boardFileInfoData(int bno) {
		// TODO Auto-generated method stub
		return dao.boardFileInfoData(bno);
	}

	@Override
	public List<BoardReplyVO> boardReplyListData(int bno) {
		// TODO Auto-generated method stub
		return dao.boardReplyListData(bno);
	}

	@Override
	public int boardReplyCount(int bno) {
		// TODO Auto-generated method stub
		return dao.boardReplyCount(bno);
	}

	@Override
	public void boardReplyInsert(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		dao.boardReplyInsert(vo);
	}

	@Override
	public void boardReReplyInsert(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		dao.boardReReplyInsert(vo);
	}

	@Override
	public void boardReplyUpdate(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		dao.boardReplyUpdate(vo);
	}

	@Override
	public void boardReplyDelete(int brno) {
		// TODO Auto-generated method stub
		dao.boardReplyDelete(brno);
	}

	@Override
	public void boardReplyAllDelete(int bno) {
		// TODO Auto-generated method stub
		dao.boardReplyAllDelete(bno);
	}

	@Override
	public int boardReReplyCount(int root) {
		// TODO Auto-generated method stub
		return dao.boardReReplyCount(root);
	}

	@Override
	public List<NoticeBoardVO> noticeboardListData(int start, int end) {
		// TODO Auto-generated method stub
		return dao.noticeboardListData(start, end);
	}

	@Override
	public List<NoticeBoardVO> noticeboardTypeListData(int cno, int start, int end) {
		// TODO Auto-generated method stub
		return dao.noticeboardTypeListData(cno, start, end);
	}

	@Override
	public int noticeboardTotalPage() {
		// TODO Auto-generated method stub
		return dao.noticeboardTotalPage();
	}

	@Override
	public void noticeboardInsert(NoticeBoardVO vo) {
		// TODO Auto-generated method stub
		dao.noticeboardInsert(vo);
	}

	@Override
	public NoticeBoardVO noticeboardDetailData(int nbno) {
		// TODO Auto-generated method stub
		return dao.noticeboardDetailData(nbno);
	}

	@Override
	public NoticeBoardVO noticeboardUpdateData(int nbno) {
		// TODO Auto-generated method stub
		return dao.noticeboardUpdateData(nbno);
	}

	@Override
	public String noticeboardUpdate(NoticeBoardVO vo) {
		// TODO Auto-generated method stub
		return dao.noticeboardUpdate(vo);
	}

	@Override
	public String noticeboardDelete(int nbno) {
		// TODO Auto-generated method stub
		return dao.noticeboardDelete(nbno);
	}

	@Override
	public NoticeBoardVO noticeboardFileInfoData(int nbno) {
		// TODO Auto-generated method stub
		return dao.noticeboardFileInfoData(nbno);
	}

	@Override
	public int noticeboardadmin(String id) {
		// TODO Auto-generated method stub
		return dao.noticeboardadmin(id);
	}


}
