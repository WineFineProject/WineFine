package com.sist.service;

import java.util.List;

import com.sist.vo.BoardVO;

public interface BoardService {
	public List<BoardVO> boardListData(int start, int end);
	public List<BoardVO> boardTypeListData(int cno, int start, int end);
	public int boardTotalPage();
	public String boardNickname(String id);
	public void boardInsert(BoardVO vo);
	public BoardVO boardDetailData(int bno);
	public BoardVO databoardUpdateData(int bno);
	public void boardUpdate(BoardVO vo);
	public void boardDelete(int bno);
	public BoardVO boardFileInfoData(int bno);
}
