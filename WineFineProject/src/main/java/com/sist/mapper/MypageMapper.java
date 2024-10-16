package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.vo.*;


public interface MypageMapper {
	
	// 개인 정보 불러오기
	@Select("SELECT * FROM wine_member WHERE userId=#{userId}")
	public MemberVO	getMyId(@Param("userId") String userId);
	
	// 개인 정보 수정
	@Update("UPDATE wine_member SET nickname=#{nickname},post=#{post},addr1=#{addr1},addr2=#{addr2},phone=#{phone},email=#{email}"
			+ "WHERE userId=#{userId}")
	public int updateMyInfo(MemberVO vo);
	
	// 작성 글 목록
	@Select("SELECT bno,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,num "
	        +"FROM (SELECT bno,subject,nickname,regdate,hit,rownum as num "
	        	  +"FROM (SELECT bno,subject,nickname,regdate,hit "
	        	  		+"FROM board WHERE nickname = #{nickname} ORDER BY bno DESC)) "
	        +"WHERE num BETWEEN #{start} AND #{end}")
    public List<BoardVO> myBoardListData(@Param("nickName") String nickName, @Param("start") int start, @Param("end") int end);

	// 전체 총페이지
	 @Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE nickname = #{nickname}")
	 public int myPageBoardTotalPage(@Param("nickName") String nickName);
	
	 
}

