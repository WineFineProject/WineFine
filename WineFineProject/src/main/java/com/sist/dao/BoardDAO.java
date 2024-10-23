package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.vo.Wine_ReportVO;

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
	 public int cboardTotalPage(int type)
	 {
		 return mapper.cboardTotalPage(type);
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
	 public BoardVO boardUpdateData(int bno)
	 {
		   return mapper.boardDetailData(bno);
	 }
	  
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
	 
	 public List<BoardVO> boardfindnListData(String find, int start, int end)
	 {
		 return mapper.boardfindnListData(find, start, end);
	 }
	 public List<BoardVO> boardfindTypenListData(int type, String find, int start, int end)
	 {
		 return mapper.boardfindTypenListData(type, find, start, end);
	 }
	 public List<BoardVO> boardfindsListData(String find, int start, int end)
	 {
		 return mapper.boardfindsListData(find, start, end);
	 }
	 public List<BoardVO> boardfindTypesListData(int type, String find, int start, int end)
	 {
		 return mapper.boardfindTypesListData(type, find, start, end);
	 }
	 public int boardnfTotalPage(String find)
	 {
		 return mapper.boardnfTotalPage(find);
	 }
	 public int cboardnfTotalPage(int type, String find)
	 {
		 return mapper.cboardnfTotalPage(type, find);
	 }
	 public int boardsfTotalPage(String find)
	 {
		 return mapper.boardsfTotalPage(find);
	 }
	 public int cboardsfTotalPage(int type, String find)
	 {
		 return mapper.cboardsfTotalPage(type, find);
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
	 public void boardRepliesDelete(int brno)
	 {
		 mapper.boardRepliesDelete(brno);
	 }
	 public void boardReplyAllDelete(int bno)
	 {
		 mapper.boardReplyAllDelete(bno);
	 }
	 public void boardReportInsert (Wine_ReportVO vo)
	 {
		 mapper.boardReportInsert(vo);
	 }
// noticeboard
	 public List<BoardVO> noticeboardListData(int start, int end)
	 {
		 return mapper.noticeboardListData(start, end);
	 }
	 public List<BoardVO> noticeboardTypeListData(int cno, int start, int end)
	 {
		 return mapper.noticeboardTypeListData(cno, start, end);
	 }
	 public int noticeboardTotalPage()
	 {
		 return mapper.noticeboardTotalPage();
	 }
	 public void noticeboardInsert(BoardVO vo)
	 {
		 mapper.noticeboardInsert(vo);
	 }
	 public BoardVO noticeboardDetailData(int bno)
	 {
		 mapper.hitIncrement(bno);
		 return mapper.noticeboardDetailData(bno);
	 }
	 
	 // 수정하기 
	   //1. 이전에 입력한 데이터를 읽어서 출력 
	   public BoardVO noticeboardUpdateData(int bno)
	   {
		   return mapper.noticeboardDetailData(bno);
	   }
	   //2.수정
	   public String noticeboardUpdate(BoardVO vo)
	   {   
		   String result="yes";
		   mapper.noticeboardUpdate(vo);
		   return result;
	   }

     
	   // 댓글 정보
	   public int boardInfo(int brno)
	   {
		   return mapper.boardInfo(brno);
	   }
}
