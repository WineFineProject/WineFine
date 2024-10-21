package com.sist.mapper;

import java.util.List;
import java.util.Map;

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
	public int reviewTotalCount(int wno);
//	삭제
	@Delete("DELETE FROM wine_review "
			+ "WHERE wrvno = #{wrvno}")
	public void reviewDelete(WineReviewVO vo);
	
	public List<WineReviewVO> myReviewList(Map map);	
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM wine_review WHERE userid=#{userId}")
	public int myReviewTotalPage(Map map);
	
	@Delete("DELETE FROM wine_review WHERE wrvno=#{wrvno}")
	public void mypageReviewDelete(int wrvno);
	
	@Update("UPDATE wine SET score=(SELECT NVL(AVG(srating),0) FROM wine_review WHERE wno=#{wno}) WHERE wno=#{wno}")
	public void wineScoreUpdate(int wno);
	
	@Select("SELECT COUNT(*) FROM wine_review "
			+ "WHERE wno = #{wno} AND userid = #{userid} ")
	public int reviewCheck (@Param("wno")int wno, @Param("userid")String userid);
}





