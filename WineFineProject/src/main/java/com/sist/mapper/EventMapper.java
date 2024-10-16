package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
public interface EventMapper {
  // 이벤트 목록	
  @Select("SELECT weno, title, TO_CHAR(eventdate,'yyyy-mm-dd') as eday, maxperson, address, poster, num "
		  +"FROM (SELECT weno, title, eventdate, maxperson, address, poster, rownum as num "
		  +"FROM (SELECT weno, title, eventdate, maxperson, address, poster "
		  +"FROM wine_event ORDER BY weno DESC)) "
		  +"WHERE num BETWEEN #{start} AND #{end}")
  public List<EventVO> eventListData(@Param("start") int start, @Param("end") int end);
  
  // 이벤트 총페이지	
  @Select("SELECT COUNT(*) FROM wine_event")
  public int eventTotalPage();
  
  // 이벤트 상세	
  @Select("SELECT weno, title, TO_CHAR(eventdate,'yyyy-mm-dd') as eday, maxperson, address, poster "
		  +"FROM wine_event "
		  +"WHERE weno=#{weno}")
  public EventVO eventDetailData(int weno);
}
