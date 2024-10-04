package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.NoticeBoardVO;

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
	   public BoardVO boardUpdateData(int bno)
	   {
		   return mapper.boardDetailData(bno);
	   }
	   //2.수정
	   public String boardUpdate(BoardVO vo)
	   {   
		   String result="yes";
		   mapper.boardUpdate(vo);
		   return result;
	   }
	   
	 public String boardDelete(int bno)
	 {
		 String result="yes";
		 mapper.boardDelete(bno);
		 return result;
	 }
	 public BoardVO boardFileInfoData(int bno)
	 {
		 return mapper.boardFileInfoData(bno);
	 }
	 
	 // 댓글
	 
	 public List<BoardReplyVO> boardReplyListData(int bno)
	 {
		 return mapper.boardReplyListData(bno);
	 }
	 public int boardReplyCount(int bno)
	 {
		 return mapper.boardReplyCount(bno);
	 }
	 public int boardReReplyCount(int root)
	 {
		 return mapper.boardReReplyCount(root);
	 }
	 public void boardReplyInsert(BoardReplyVO vo)
	 {
		 mapper.boardReplyInsert(vo);
	 }
	 public void boardReReplyInsert(BoardReplyVO vo)
	 {
		 mapper.boardReReplyInsert(vo);
	 }
	 public void boardReplyUpdate(BoardReplyVO vo)
	 {
		 mapper.boardReplyUpdate(vo);
	 }
	 public void boardReplyDelete(int brno)
	 {
		 mapper.boardReplyDelete(brno);
	 }
	 public void boardReplyAllDelete(int bno)
	 {
		 mapper.boardReplyAllDelete(bno);
	 }
	 
	 // noticeboard
	 public List<NoticeBoardVO> noticeboardListData(int start, int end)
	 {
		 return mapper.noticeboardListData(start, end);
	 }
	 public List<NoticeBoardVO> noticeboardTypeListData(int cno, int start, int end)
	 {
		 return mapper.noticeboardTypeListData(cno, start, end);
	 }
	 public int noticeboardTotalPage()
	 {
		 return mapper.noticeboardTotalPage();
	 }
	 public int noticeboardadmin(String id)
	 {
		 return mapper.noticeboardadmin(id);
	 }
	 public void noticeboardInsert(NoticeBoardVO vo)
	 {
		 mapper.noticeboardInsert(vo);
	 }
	 public NoticeBoardVO noticeboardDetailData(int nbno)
	 {
		 mapper.noticehitIncrement(nbno);
		 return mapper.noticeboardDetailData(nbno);
	 }
	 
	 // 수정하기 
	   //1. 이전에 입력한 데이터를 읽어서 출력 
	   public NoticeBoardVO noticeboardUpdateData(int nbno)
	   {
		   return mapper.noticeboardDetailData(nbno);
	   }
	   //2.수정
	   public String noticeboardUpdate(NoticeBoardVO vo)
	   {   
		   String result="yes";
		   mapper.noticeboardUpdate(vo);
		   return result;
	   }
	   
	 public String noticeboardDelete(int nbno)
	 {
		 String result="yes";
		 mapper.noticeboardDelete(nbno);
		 return result;
	 }
	 public NoticeBoardVO noticeboardFileInfoData(int nbno)
	 {
		 return mapper.noticeboardFileInfoData(nbno);
	 }
}
