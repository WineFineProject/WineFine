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
	
	// 카테고리 별 목록 
	 @Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
			 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
			 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
			 +"FROM board WHERE cno = #{cno} ORDER BY bno DESC)) "
			 +"WHERE num BETWEEN #{start} AND #{end}")
	 public List<BoardVO> boardTypeListData(@Param("cno") int type, @Param("start") int start, @Param("end") int end);
	 
	// 전체 총페이지
	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board")
	  public int boardTotalPage();
	
	 // 카테고리별 총페이지
	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno = #{cno}")
	  public int cboardTotalPage(@Param("cno") int type);
	 
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
	 
	// 내용보기(번호, 타입, 아이디, 제목, 닉네임, 작성일, 내용, 조회수, 사진 파일명, 사진 용량, 사진개수) 
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
			 +"cno=#{cno},subject=#{subject},content=#{content},regdate=SYSDATE, "
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
	 
	// 게시글 검색(작성자-닉네임)
	// 전체 게시글 목록
		@Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
				 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
				 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
				 +"FROM board WHERE nickname LIKE '%'||#{find}||'%' ORDER BY bno DESC)) "
				 +"WHERE num BETWEEN #{start} AND #{end}")
		 public List<BoardVO> boardfindnListData(@Param("find") String find, @Param("start") int start, @Param("end") int end);
		
		// 카테고리 별 목록 
		 @Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
				 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
				 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
				 +"FROM board WHERE cno = #{cno} AND nickname LIKE '%'||#{find}||'%' ORDER BY bno DESC)) "
				 +"WHERE num BETWEEN #{start} AND #{end}")
		 public List<BoardVO> boardfindTypenListData(@Param("cno") int type, @Param("find") String find, @Param("start") int start, @Param("end") int end);

		// 닉네임 검색 전체 총페이지
		 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE nickname LIKE '%'||#{find}||'%' ")
		  public int boardnfTotalPage(@Param("find") String find);
		
		 // 닉네임 검색 카테고리별 총페이지
		 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno = #{cno} AND nickname LIKE '%'||#{find}||'%' ")
		  public int cboardnfTotalPage(@Param("cno") int type, @Param("find") String find);
		 
		 // 게시글 검색(제목)
		// 전체 게시글 목록
			@Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
					 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
					 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
					 +"FROM board WHERE subject LIKE '%'||#{find}||'%' ORDER BY bno DESC)) "
					 +"WHERE num BETWEEN #{start} AND #{end}")
			 public List<BoardVO> boardfindsListData(@Param("find") String find, @Param("start") int start, @Param("end") int end);
			
			// 카테고리 별 목록 
			 @Select("SELECT bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
					 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
					 +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
					 +"FROM board WHERE cno = #{cno} AND subject LIKE '%'||#{find}||'%' ORDER BY bno DESC)) "
					 +"WHERE num BETWEEN #{start} AND #{end}")
			 public List<BoardVO> boardfindTypesListData(@Param("cno") int type, @Param("find") String find, @Param("start") int start, @Param("end") int end);
			
			 // 제목 검색 전체 총페이지
			 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE subject LIKE '%'||#{find}||'%'")
			  public int boardsfTotalPage(@Param("find") String find);
			
			 // 제목 검색 카테고리 별 총페이지
			 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno = #{cno} AND subject LIKE '%'||#{find}||'%'")
			  public int cboardsfTotalPage(@Param("cno") int type, @Param("find") String find);
// 댓글
		 
	// 댓글 목록
	 @Select("SELECT brno,bno,id,nickname,msg,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday,root,depth "
			 +"FROM boardreply "
			 +"WHERE bno=#{bno} "
			 +"ORDER BY root DESC , depth ASC")
	  public List<BoardReplyVO> boardReplyListData(int bno);
	 
	// 댓글 수
	 @Select("SELECT COUNT(*) FROM boardreply WHERE bno=#{bno}")
	 public int boardReplyCount(int bno);
	 
	 // 댓글 추가
	 @SelectKey(keyProperty = "brno",resultType = int.class,before = true, 
			  statement = "SELECT NVL(MAX(brno)+1,1) as brno FROM boardreply")
	 @Insert("INSERT INTO boardreply(brno,bno,id,nickname,msg,root,depth) VALUES("
			 +"#{brno},#{bno},#{id},#{nickname},#{msg},(SELECT NVL(MAX(root)+1,1) as root FROM boardreply),1)")
	 public void boardReplyInsert(BoardReplyVO vo);
	 
	 // 대댓글 추가
	 @SelectKey(keyProperty = "brno",resultType = int.class,before = true, 
			  statement = "SELECT NVL(MAX(brno)+1,1) as brno FROM boardreply")
	 @Insert("INSERT INTO boardreply(brno,bno,id,nickname,msg,root,depth) VALUES "
	 		+ "(#{brno}, #{bno}, #{id},#{nickname}, #{msg}, #{root}, 2)")
	 public void boardReReplyInsert(BoardReplyVO vo);
	 
	 // 대댓글 여부 확인
	 @Select("SELECT COUNT(*) FROM boardreply WHERE root=#{root} AND depth=2")
	 public int boardReReplyCount(int root);
	 
	 // 댓글 수정
	 @Update("UPDATE boardreply SET "
			 +"msg=#{msg} "
			 +"WHERE brno=#{brno}")
	  public void boardReplyUpdate(BoardReplyVO vo);
	 
	 // 댓글 삭제
	 @Delete("DELETE FROM boardreply "
			 +"WHERE brno=#{brno}")
	 public void boardReplyDelete(int brno);
	
	 //게시물의 댓글 전체 삭제
	 @Delete("DELETE FROM boardreply "
			 +"WHERE bno=#{bno}")
	 public void boardReplyAllDelete(int bno);
	 
//noticeboard
	// 전체 게시글 목록
		@Select("SELECT nbno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
				 +"FROM (SELECT nbno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
				 +"FROM (SELECT nbno, cno, subject, nickname, regdate, hit, filecount "
				 +"FROM noticeboard ORDER BY nbno DESC)) "
				 +"WHERE num BETWEEN #{start} AND #{end}")
		 public List<NoticeBoardVO> noticeboardListData(@Param("start") int start, @Param("end") int end);
		
		// 카테고리 별 목록 
		 @Select("SELECT nbno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
				 +"FROM (SELECT nbno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
				 +"FROM (SELECT nbno, cno, subject, nickname, regdate, hit, filecount "
				 +"FROM noticeboard WHERE cno = #{cno} ORDER BY nbno DESC)) "
				 +"WHERE num BETWEEN #{start} AND #{end}")
		 public List<NoticeBoardVO> noticeboardTypeListData(@Param("cno") int type, @Param("start") int start, @Param("end") int end);
		 
		// 전체 총페이지
		 @Select("SELECT CEIL(COUNT(*)/10.0) FROM noticeboard")
		  public int noticeboardTotalPage();
				 
		// 추가(글쓰기)
		 @SelectKey(keyProperty = "nbno",resultType = int.class,before = true,
				  statement = "SELECT NVL(MAX(nbno)+1,1) as nbno FROM noticeboard")
		 @Insert("INSERT INTO noticeboard(nbno,cno,id,nickname,subject,content, "
				 +"filename,filesize,filecount) VALUES("
				 +"#{nbno},#{cno},#{id},'관리자',#{subject},#{content}, "
				 +"#{filename},#{filesize},#{filecount})")
		  public void noticeboardInsert(NoticeBoardVO vo);
		 
		// 내용보기(번호, 타입, 아이디, 제목, 닉네임, 작성일, 내용, 조회수, 사진 파일명, 사진 용량, 사진개수) 
		 @Select("SELECT nbno,cno,id,nickname,subject,content,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday, "
				 +"hit,filename,filesize,filecount "
				 +"FROM noticeboard "
				 +"WHERE nbno=#{nbno}")
		  public NoticeBoardVO noticeboardDetailData(int nbno);
		// 조회수 증가
		 @Update("UPDATE noticeboard SET "
				 +"hit=hit+1 "
				 +"WHERE nbno=#{nbno}")
		  public void noticehitIncrement(int nbno);
		
		// 수정하기 
		 @Update("UPDATE noticeboard SET "
				 +"cno=#{cno},subject=#{subject},content=#{content},regdate=SYSDATE, "
				 + "filename=#{filename},filesize=#{filesize},filecount=#{filecount} "
				 +"WHERE nbno=#{nbno}")
		  public void noticeboardUpdate(NoticeBoardVO vo);
		 
		// 삭제하기
		 @Delete("DELETE FROM noticeboard "
				  +"WHERE nbno=#{nbno}")
		  public void noticeboardDelete(int nbno);
		// 첨부파일 정보
		 @Select("SELECT filename,filecount FROM noticeboard "
				  +"WHERE nbno=#{nbno}")
		  public NoticeBoardVO noticeboardFileInfoData(int nbno);
	
}
