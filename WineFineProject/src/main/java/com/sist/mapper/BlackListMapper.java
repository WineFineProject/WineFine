package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
public interface BlackListMapper {
  // 블랙리스트 목록 출력
  @Select("SELECT blno, recvid, sendid, content, TO_CHAR(regdate, 'YYYY-MM-DD') as dbday num "
		  +"FROM (SELECT blno, recvid, sendid, content, regdate rownum as num "
		  +"FROM (SELECT blno, recvid, sendid, content, regdate "
		  +"FROM blacklist ORDER BY blno DESC)) "
		  +"WHERE num BETWEEN #{start} AND #{end}")	
  public List<BlackListVO> blackListData(@Param("start") int start, @Param("end") int end);
  //블랙리스트 추가
  @Insert("INSERT INTO blacklist VALUES(" 
		  +"(SELECT NVL(MAX(blno)+1, 1) FROM blacklist),#{recvid},#{sendid},#{content},SYSDATE)")
  public void blackListInsert(BlackListVO vo);
}
