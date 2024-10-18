package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;
import com.sist.vo.*;
public interface WineReviewMapper {
//	추가
	@Insert("INSERT INTO wine_review (wrvno, wno, userid, srating, regdate, nickname, content) "
			+ "VALUES (wrv_wrvno_seq.nextval, #{wno}, #{userid}, #{srating}, SYSDATE, #{nickname}, #{content} ) ")
	public void reviewInsert(WineReviewVO vo);
//	상세
	@Select("SELECT wrvno, wno, userid, srating, TO_CHAR(regdate,'YYYY-MM-DD HH24:mi:ss')as dbday,"
			+ " nickname, content "
			+ "FROM wine_review "
			+ "WHERE wno = #{wno} AND rownum <= #{count} "
			+ "ORDER BY wrvno DESC ")
	public List<WineReviewVO> reviewList(@Param("wno")int wno,@Param("count")int count);
//	총 리뷰 수
	@Select("SELECT COUNT(*) "
			+ "FROM wine_review "
			+ "WHERE wno = #{wno} ")
	public WineReviewVO reviewTotalCount(int wno);
//	삭제
	@Delete("DELETE FROM wine_review "
			+ "WHERE wno = #{wno} AND userid = #{userid} ")
	public void reviewDelete(WineReviewVO vo);
	
	
	
}





