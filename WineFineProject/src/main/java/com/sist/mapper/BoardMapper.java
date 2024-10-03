package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;


public interface BoardMapper {
	// 전체 게시글 목록
	@Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
			 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
			 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
			 +"FROM board ORDER BY bno DESC)) "
			 +"WHERE num BETWEEN #{start} AND #{end}")
	 public List<BoardVO> boardListData(@Param("start") int start, @Param("end") int end);
	
	// 카테고리 별 목록 (//댓글 수(?)//)
	 @Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
			 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
			 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
			 +"FROM board WHERE cno = #{cno} ORDER BY bno DESC)) "
			 +"WHERE num BETWEEN #{start} AND #{end}")
	 public List<BoardVO> boardTypeListData(@Param("cno") int type, @Param("start") int start, @Param("end") int end);
	 
	// 전체 총페이지
	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board")
	  public int boardTotalPage();
	 
	// 닉네임 구하기
	 @Select("SELECT nickname FROM member WHERE id LIKE '%'||#{id}||'%' ")
	 public String boardNickname(String id);
	 
	// 추가(글쓰기)
	 @SelectKey(keyProperty = "bno",resultType = int.class,before = true,
			  statement = "SELECT NVL(MAX(bno)+1,1) as bno FROM board")
	 @Insert("INSERT INTO board(bno,cno,id,nickname,subject,content, "
			 +"filename,filesize,filecount) VALUES("
			 +"#{bno},#{cno},#{id},#{nickname},#{subject},#{content}, "
			 +"#{filename},#{filesize},#{filecount})")
	  public void boardInsert(BoardVO vo);
	 
	// 내용보기(번호, 타입, 아이디, 제목, 닉네임, 작성일, 내용, 조회수, 사진 파일명, 사진 용량, 사진개수, //댓글 수//) 
	 @Select("SELECT bno,cno,id,nickname,subject,content,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday, "
			 +"hit,filename,filesize,filecount "
			 +"FROM board "
			 +"WHERE bno=#{bno}")
	  public BoardVO boardDetailData(int bno);
	// 조회수 증가
	 @Update("UPDATE board SET "
			 +"hit=hit+1 "
			 +"WHERE bno=#{bno}")
	  public void hitIncrement(int bno);
	
	// 수정하기 
	 @Update("UPDATE board SET "
			 +"subject=#{subject},content=#{content},regdate=SYSDATE, "
			 + "filename=#{filename},filesize=#{filesize},filecount=#{filecount} "
			 +"WHERE bno=#{bno}")
	  public void boardUpdate(BoardVO vo);
	 
	// 삭제하기
	 @Delete("DELETE FROM board "
			  +"WHERE bno=#{bno}")
	  public void boardDelete(int bno);
	// 첨부파일 정보
	 @Select("SELECT filename,filecount FROM board "
			  +"WHERE bno=#{bno}")
	  public BoardVO boardFileInfoData(int bno);
	 
	// 게시글 검색(닉네임)
	
	// 게시글 검색(제목)
	
	// 댓글 추가
	
	// 댓글 출력
	
	// 댓글 수정
	
	// 댓글 삭제
	
	
}
