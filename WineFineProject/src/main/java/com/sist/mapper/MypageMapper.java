package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.vo.BoardVO;


public interface MypageMapper {
	
	@Select("SELECT * "
			+ "FROM BOARD "
			+ "WHERE ID = #{userId} ORDER BY BNO DESC")
    public List<BoardVO> getBoardsByUserId(@Param("userId") String userId);
	
	 @Select("SELECT COUNT(*) "
	 		+ "FROM BOARD "
	 		+ "WHERE ID=#{userId}")
	int getboardCountByUserId(@Param("userId") String userId);

	@Select("SELECT * "
			+ "FROM BOARD "
			+ "WHERE ID=#{userId} ORDER BY BNO DESC LIMIT #{limit} OFFSET #{offset}")
	public List<BoardVO> getBoardsByUserIdWithPaging(@Param("userId") String userId, @Param("limit") int limit, @Param("offset") int offset);
	
	 @Select("SELECT CNO,COUNT(*) as count "
	 		+ "FROM BOARD "
	 		+ "WHERE ID = #{userId} GROUP BY CNO")
	 public List<Map<String, Object>> getBoardCountByCategoryForUser(@Param("userId") String userId);
	
//	
//	// 작성 글 목록
//	@Select("SELECT bno,cno,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,filecount,num "
//	        +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount,rownum as num "
//	        	  +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount "
//	        	  		+"FROM board WHERE cno<=3 AND nickname = #{nickname} ORDER BY bno DESC)) "
//	        +"WHERE num BETWEEN #{start} AND #{end}")
//    public List<BoardVO> myBoardListData(@RequestParam("nickname") String nickname,
//    									 @RequestParam("start") int start, 
//    									 @RequestParam("end") int end);
//    
//	// 카테고리 별 목록 
//	 @Select("SELECT bno, cno,subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,filecount,num "
//			 +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount,rownum as num "
//			 +"FROM (SELECT bno,cno,subject,nickname,regdate,hit,filecount "
//			 +"FROM board "
//			 + "FROM board WHERE cno=#{cno} AND nickname = #{nickname} ORDER BY bno DESC))) "
//			 +"WHERE num BETWEEN #{start} AND #{end}")
//	 public List<BoardVO> boardTypeListData(@Param("nickname") String nickname, @Param("cno") int type, @Param("start") int start, @Param("end") int end);
//	 
//	// 전체 총페이지
//	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno<=3 AND nickname = #{nickname}")
//	 public int myPageBoardTotalPage(@Param("nickname") String nickname);
//	
//	 // 카테고리별 총페이지
//	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE cno=#{cno} AND id=#{id}")
//	 public int myPageCBoardTotalPage(@Param("nickname") String nickname, @Param("cno") int type);
}

