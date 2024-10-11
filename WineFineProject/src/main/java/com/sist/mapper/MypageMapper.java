package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;

import com.sist.vo.BoardVO;


public interface MypageMapper {
	// 작성 글 목록
	@Select("SELECT bno,cno,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,filecount,num "
	        +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount,rownum as num "
	        	  +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount "
	        	  		+"FROM board WHERE cno<=3 AND nickname = #{nickname} ORDER BY bno DESC)) "
	        +"WHERE num BETWEEN #{start} AND #{end}")
    public List<BoardVO> myBoardListData(@Param("nickName") String nickname,@Param("start") int start, @Param("end") int end);
    
	// 카테고리 별 목록 
	 @Select("SELECT bno, cno,subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,filecount,num "
			 +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount,rownum as num "
			 +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount "
			 +"FROM board "
			 + "FROM board WHERE cno=#{cno} AND nickname = #{nickname} ORDER BY bno DESC))) "
			 +"WHERE num BETWEEN #{start} AND #{end}")
	 public List<BoardVO> boardTypeListData(@Param("nickName") String nickname, @Param("cno") int type, @Param("start") int start, @Param("end") int end);
	 
	// 전체 총페이지
	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno<=3 AND nickname = #{nickname}")
	 public int myPageBoardTotalPage(@Param("nickName") String nickname);
	
	 // 카테고리별 총페이지
	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno=#{cno} AND id=#{id}")
	 public int myPageCBoardTotalPage(@Param("nickName") String nickname, @Param("cno") int type);
}

