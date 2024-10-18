package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
public interface BlackListMapper {
	    // 블랙리스트 목록
		@Select("SELECT userId, nickName, userName, birthday, sex, phone, post, addr1, addr2, grade, photo, point, "
				+ "authority, regday, TO_CHAR(lastlogin, 'YYYY-MM-DD HH24:MI:SS') as lastloginday, email, num "
				+ "FROM (SELECT wm.userId, wm.nickName, wm.userName, wm.birthday, wm.sex, wm.phone, wm.post, wm.addr1, wm.addr2, wm.grade, wm.photo, wm.point, "
				+ "a.authority, TO_CHAR(wm.regdate, 'YYYY-MM-DD') as regday, wm.lastlogin, email, rownum as num "
				+ "FROM wine_member wm "
		        + "JOIN authority a ON wm.userId = a.userId "
		        + "JOIN blacklist b ON wm.userId = b.recvid "
		        + "WHERE b.sendid=#{userId} AND a.authority = 'ROLE_USER' AND ${option} like '%'||#{fd}||'%' "
		        + "ORDER BY wm.regdate DESC) "
				+ "WHERE num BETWEEN #{start} AND #{end}")
		public List<MemberVO> blackList(Map map);
		
		// 블랙리스트 목록 페이징
		@Select("SELECT CEIL(COUNT(*) / 10.0) FROM blacklist JOIN wine_member ON wine_member.userId = blacklist.recvid JOIN authority ON blacklist.recvid=authority.userId WHERE authority='ROLE_USER' AND ${option} like '%'||#{fd}||'%' ")
		public int blackListCount(Map map);
		
		// 블랙리스트 목록 삭제
		@Delete("DELETE FROM blacklist WHERE recvid=#{recvid} AND sendid=#{sendid}")
		public void blackListDelete(BlackListVO vo);
		
	    //블랙리스트 추가
	    @Insert("INSERT INTO blacklist VALUES(" 
			    +"(SELECT NVL(MAX(blno)+1, 1) FROM blacklist),#{recvid},#{sendid},#{content},SYSDATE)")
	    public void blackListInsert(BlackListVO vo);
}
