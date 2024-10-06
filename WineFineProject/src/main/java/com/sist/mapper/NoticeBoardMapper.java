package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.NoticeBoardVO;

public interface NoticeBoardMapper {
	
	// 판매자 공지사항 등록
	@Insert("INSERT INTO noticeboard VALUES((SELECT NVL(MAX(nbno)+1, 1) FROM noticeboard), #{subject}, #{content}, #{userid}, "
			+ "#{nickname}, #{type}, #{target}, sysdate, 0, #{isNotice})")
	public void noticeBoardInsert(NoticeBoardVO vo);
	
	// 판매자 공지 팝업 업데이트
	@Update("UPDATE noticeboard SET isnotice=0 WHERE type=#{type} AND target=#{target}")
	public void noticeBoardPopupUpdate(NoticeBoardVO vo);
	
	public List<NoticeBoardVO> sellerNoticeList(Map map);
	
	// 판매자 공지 COUNT
	@Select("SELECT COUNT(*) FROM noticeboard WHERE id=#{id}")
	public int sellerNoticeTotalPage(Map map);
}
