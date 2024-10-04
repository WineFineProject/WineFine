package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
import java.util.*;
public interface NoticeMapper {
	@Insert("INSERT INTO wine_notice (nno, subject, content, sendid, recvid) values ((SELECT NVL(MAX(nno)+1, 1) FROM wine_notice), #{subject}, #{content}, #{sendid}, #{recvid})")
	public void noticeInsert(NoticeVO vo);
	
	@Select("SELECT nno, subject, content, sendid, recvid, state, TO_CHAR(regdate, 'YYYY-MM-DD') as dbday "
			+ "FROM wine_notice WHERE recvid=#{id} AND state=0 ORDER BY nno DESC")
	public List<NoticeVO> noticeNewListData(String id);
	
	@Select("SELECT COUNT(*) FROM wine_notice WHERE recvid=#{id} AND state=0")
	public int noticeNewCount(String id);

	@Select("SELECT nno, subject, content, sendid, recvid, state, TO_CHAR(regdate, 'YYYY-MM-DD') as dbday "
			+ "FROM wine_notice WHERE recvid=#{id} AND state=1 AND rownum<=10 ORDER BY nno DESC")
	public List<NoticeVO> noticeOldListData(String id);
	
	@Update("UPDATE wine_notice SET state=1 WHERE nno=#{nno}")
	public void noticeStateUpdate(int nno);
}
