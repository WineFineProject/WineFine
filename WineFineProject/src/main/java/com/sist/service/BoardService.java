package com.sist.service;

import java.util.List;

import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.Wine_ReportVO;

public interface BoardService {
	public List<BoardVO> boardListData(int start, int end);
	public List<BoardVO> boardTypeListData(int cno, int start, int end);
	public int boardTotalPage();
	public int cboardTotalPage(int type);
	public void boardInsert(BoardVO vo);
	public BoardVO boardDetailData(int bno);
	public BoardVO boardUpdateData(int bno);
	public String boardUpdate(BoardVO vo);
	public String boardDelete(int bno);
	public List<BoardVO> boardfindnListData(String find, int start, int end);
	public List<BoardVO> boardfindTypenListData(int type, String find, int start, int end);
	public List<BoardVO> boardfindsListData(String find, int start, int end);
	public List<BoardVO> boardfindTypesListData(int type, String find, int start, int end);
	public int boardnfTotalPage(String find);
	public int cboardnfTotalPage(int type, String find);
	public int boardsfTotalPage(String find);
	public int cboardsfTotalPage(int type, String find);
	
	public List<BoardReplyVO> boardReplyListData(int bno);
	public int boardReplyCount(int bno);
	public int boardReReplyCount(int root);
	public void boardReplyInsert(BoardReplyVO vo);
	public void boardReReplyInsert(BoardReplyVO vo);
	public void boardReplyUpdate(BoardReplyVO vo);
	public void boardReplyDelete(int brno);
	public void boardRepliesDelete(int brno);
	public void boardReplyAllDelete(int bno);
	public void boardReportInsert (Wine_ReportVO vo);
	public int boardInfo(int brno);
	
	public List<BoardVO> noticeboardListData(int start, int end);
	public List<BoardVO> noticeboardTypeListData(int cno, int start, int end);
	public int noticeboardTotalPage();
	public void noticeboardInsert(BoardVO vo);
	public BoardVO noticeboardDetailData(int bno);
	public BoardVO noticeboardUpdateData(int bno);
	public String noticeboardUpdate(BoardVO vo);
}
