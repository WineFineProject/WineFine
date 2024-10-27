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
	public int cboardTotalPage(int type) {
		// TODO Auto-generated method stub
		return dao.cboardTotalPage(type);
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
	public List<BoardVO> boardfindnListData(String find, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardfindnListData(find, start, end);
	}

	@Override
	public List<BoardVO> boardfindTypenListData(int type, String find, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardfindTypenListData(type, find, start, end);
	}

	@Override
	public List<BoardVO> boardfindsListData(String find, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardfindsListData(find, start, end);
	}

	@Override
	public List<BoardVO> boardfindTypesListData(int type, String find, int start, int end) {
		// TODO Auto-generated method stub
		return dao.boardfindTypesListData(type, find, start, end);
	}

	@Override
	public int boardnfTotalPage(String find) {
		// TODO Auto-generated method stub
		return dao.boardnfTotalPage(find);
	}

	@Override
	public int cboardnfTotalPage(int type, String find) {
		// TODO Auto-generated method stub
		return dao.cboardnfTotalPage(type, find);
	}

	@Override
	public int boardsfTotalPage(String find) {
		// TODO Auto-generated method stub
		return dao.boardsfTotalPage(find);
	}

	@Override
	public int cboardsfTotalPage(int type, String find) {
		// TODO Auto-generated method stub
		return dao.cboardsfTotalPage(type, find);
	}
	
// 댓글
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
	public int boardReReplyCount(int root) {
		// TODO Auto-generated method stub
		return dao.boardReReplyCount(root);
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
	public void boardRepliesDelete(int brno) {
		// TODO Auto-generated method stub
		dao.boardRepliesDelete(brno);
	}
	
	@Override
	public void boardReplyAllDelete(int bno) {
		// TODO Auto-generated method stub
		dao.boardReplyAllDelete(bno);
	}

	@Override
	public void boardReportInsert(Wine_ReportVO vo) {
		// TODO Auto-generated method stub
		dao.boardReportInsert(vo);
	}


//noticboard
	@Override
	public List<BoardVO> noticeboardListData(int start, int end) {
		// TODO Auto-generated method stub
		return dao.noticeboardListData(start, end);
	}

	@Override
	public List<BoardVO> noticeboardTypeListData(int cno, int start, int end) {
		// TODO Auto-generated method stub
		return dao.noticeboardTypeListData(cno, start, end);
	}

	@Override
	public int noticeboardTotalPage() {
		// TODO Auto-generated method stub
		return dao.noticeboardTotalPage();
	}

	@Override
	public void noticeboardInsert(BoardVO vo) {
		// TODO Auto-generated method stub
		dao.noticeboardInsert(vo);
	}

	@Override
	public BoardVO noticeboardDetailData(int bno) {
		// TODO Auto-generated method stub
		return dao.noticeboardDetailData(bno);
	}

	@Override
	public BoardVO noticeboardUpdateData(int bno) {
		// TODO Auto-generated method stub
		return dao.noticeboardUpdateData(bno);
	}

	@Override
	public String noticeboardUpdate(BoardVO vo) {
		// TODO Auto-generated method stub
		return dao.noticeboardUpdate(vo);
	}

	@Override
	public int boardInfo(int brno) {
		// TODO Auto-generated method stub
		return dao.boardInfo(brno);
	}

	@Override
	public List<FaqVO> faqList() {
		// TODO Auto-generated method stub
		return dao.faqList();
	}

}
