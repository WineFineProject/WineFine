package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.BoardVO;

public interface MypageMapper {
	// 작성 글 목록
    @Select("SELECT  bno, cno, subject, nickname, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filecount, num "
    		+"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount, rownum as num "
    			  +"FROM (SELECT bno, cno, subject, nickname, regdate, hit, filecount "
    			  		+"FROM board "
    			  		+ "WHERE cno<=3 ORDER BY bno DESC AND id=#{id})) "
    		+"WHERE num BETWEEN #{start} AND #{end}")
    public List<BoardVO> myBoardListData(@Param("start") int start, @Param("end") int end,@Param("id") String id);
}
