package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
public interface ReplyBoardMapper {
	// 목록
	@Select("SELECT wrno,userid,nickname,subject,"
			+"TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit,secret,num "
			+"FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit,secret,rownum as num "
			+"FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit,secret "
			+"FROM wine_replyboard ORDER BY group_id DESC , group_step ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyBoardVO> replyListData(@Param("start") int start, @Param("end") int end, @Param("userid") String userid);
	
    @Select("SELECT COUNT(*) FROM wine_replyboard")
    public int replyCount();
    
    // 작성
    @Insert("INSERT INTO wine_replyboard(wrno, userid, nickname, subject, content, regdate, cno, type, recvid, wno, "
    	    + "group_id, group_step, isreply, secret) "
    	    + "VALUES((SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), "
    	    + "#{userid}, #{nickname}, #{subject}, #{content}, SYSDATE, #{cno}, #{type}, #{recvid}, #{wno}, "
    	    + "#{group_id}, #{group_step}, 0, #{secret})")
    public void replyInsert(ReplyBoardVO vo);
    
    // 조회수 
    @Update("UPDATE wine_replyboard SET "
  		 +"hit = hit+1 "
  		 +"WHERE wrno=#{wrno}")
    public void hitIncrement(int wrno);
    
    // 상세보기 
    @Select("SELECT wrno,userid,nickname,subject,content,"
			+"TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit,secret "
  		    +"FROM wine_replyboard "
  		    +"WHERE wrno=#{wrno}")
    public ReplyBoardVO replyDetailData(int wrno);
    
    // 삭제
    
    // 수정
    

}
