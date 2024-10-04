package com.sist.service;

import java.util.List;

import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.NoticeBoardVO;

public interface BoardService {
	public List<BoardVO> boardListData(int start, int end);
	public List<BoardVO> boardTypeListData(int cno, int start, int end);
	public int boardTotalPage();
	public String boardNickname(String id);
	public void boardInsert(BoardVO vo);
	public BoardVO boardDetailData(int bno);
	public BoardVO boardUpdateData(int bno);
	public String boardUpdate(BoardVO vo);
	public String boardDelete(int bno);
	public BoardVO boardFileInfoData(int bno);
	
	public List<BoardReplyVO> boardReplyListData(int bno);
	public int boardReplyCount(int bno);
	public int boardReReplyCount(int root);
	public void boardReplyInsert(BoardReplyVO vo);
	public void boardReReplyInsert(BoardReplyVO vo);
	public void boardReplyUpdate(BoardReplyVO vo);
	public void boardReplyDelete(int brno);
	public void boardReplyAllDelete(int bno);
	
	public List<NoticeBoardVO> noticeboardListData(int start, int end);
	public List<NoticeBoardVO> noticeboardTypeListData(int cno, int start, int end);
	public int noticeboardTotalPage();
	public int noticeboardadmin(String id);
	public void noticeboardInsert(NoticeBoardVO vo);
	public NoticeBoardVO noticeboardDetailData(int nbno);
	public NoticeBoardVO noticeboardUpdateData(int nbno);
	public String noticeboardUpdate(NoticeBoardVO vo);
	public String noticeboardDelete(int nbno);
	public NoticeBoardVO noticeboardFileInfoData(int nbno);
}
