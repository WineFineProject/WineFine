package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.BoardVO;

@Repository
public class BoardDAO {

	@Autowired
	private BoardMapper mapper;
	
	 public List<BoardVO> boardListData(int start, int end)
	 {
		 return mapper.boardListData(start, end);
	 }
	 public List<BoardVO> boardTypeListData(int cno, int start, int end)
	 {
		 return mapper.boardTypeListData(cno, start, end);
	 }
	 public int boardTotalPage()
	 {
		 return mapper.boardTotalPage();
	 }
	 public String boardNickname(String id)
	 {
		 return mapper.boardNickname(id);
	 }
	 public void boardInsert(BoardVO vo)
	 {
		 mapper.boardInsert(vo);
	 }
	 public BoardVO boardDetailData(int bno)
	 {
		 mapper.hitIncrement(bno);
		 return mapper.boardDetailData(bno);
	 }
	 
	 // 수정하기 
	   //1. 이전에 입력한 데이터를 읽어서 출력 
	   public BoardVO databoardUpdateData(int bno)
	   {
		   return mapper.boardDetailData(bno);
	   }
	   //2.수정
	   public void boardUpdate(BoardVO vo)
	   {	
		   mapper.boardUpdate(vo);
	   }
	   
	 public void boardDelete(int bno)
	 {
		 mapper.boardDelete(bno);
	 }
	 public BoardVO boardFileInfoData(int bno)
	 {
		 return mapper.boardFileInfoData(bno);
	 }
}
