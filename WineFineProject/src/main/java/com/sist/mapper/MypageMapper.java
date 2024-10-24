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
	@Update("UPDATE wine_member SET nickname=#{nickname},post=#{post},addr1=#{addr1},addr2=#{addr2},phone=#{phone},email=#{email} "
			+ "WHERE userId=#{userId}")
	public void updateMyInfo(MemberVO vo);
	
	
	// 작성 글 목록
	@Select("SELECT bno,id,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, num "
			+"FROM (SELECT bno,id,subject,nickname,regdate, hit, rownum as num "
			+"FROM (SELECT bno,id,subject,nickname,regdate, hit "
	        +"FROM board WHERE id=#{userid} ORDER BY bno DESC)) "
	        +"WHERE num BETWEEN #{start} AND #{end} ")
    public List<BoardVO> myBoardListData(Map map);

	@Select("SELECT wrno,userid,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, num "
			+"FROM (SELECT wrno,userid,subject,nickname,regdate, hit, rownum as num "
			+"FROM (SELECT wrno,userid,subject,nickname,regdate, hit "
	        +"FROM wine_replyboard WHERE userid=#{userid} ORDER BY wrno DESC)) "
	        +"WHERE num BETWEEN #{start} AND #{end}")
    public List<ReplyBoardVO> myReplyListData(Map map);
	
	// 총페이지
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE id=#{userid}")
	public int myPageBoardTotalPage(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM wine_replyboard WHERE userid=#{userid}")
	public int myReplyTotalPage(Map map);
		 
	// 작성 댓글 목록
	@Select("SELECT brno,bno,id,nickname,msg,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday,root,depth, num "
			+"FROM (SELECT brno,bno,id,nickname,msg,regdate,root,depth, rownum as num "
			+"FROM (SELECT brno,bno,id,nickname,msg,regdate,root,depth "
			+"FROM boardreply WHERE id=#{userid} ORDER BY root DESC, depth ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<BoardReplyVO> myboardReplyListData(Map map);
	
	// 총페이지
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM boardreply WHERE id=#{userid}")
	public int myboardReplyTotalPage(Map map);
	
	 
	
	 
}

