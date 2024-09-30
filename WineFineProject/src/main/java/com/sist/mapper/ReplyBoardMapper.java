package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
public interface ReplyBoardMapper {
	// 목록
	@Select("SELECT wrno,userid,nickname,subject,"
			+"TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit,num "
			+"FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit,rownum as num "
			+"FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+"recvid,wno,group_id,group_step,isreply,hit "
			+"from wine_replyboard ORDER BY group_id DESC , group_step ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyBoardVO> replyListData(@Param("start") int start, 
			@Param("end") int end);
	// 개수
    @Select("SELECT COUNT(*) FROM wine_replyboard")
    public int replyCount();

}
