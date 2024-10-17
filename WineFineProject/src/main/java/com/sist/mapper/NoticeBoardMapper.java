package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.NoticeBoardVO;

public interface NoticeBoardMapper {
	
	// 판매자 공지사항 등록
	@Insert("INSERT INTO noticeboard VALUES((SELECT NVL(MAX(nbno)+1, 1) FROM noticeboard), #{subject}, #{content}, #{userid}, "
			+ "#{nickname}, #{type}, #{target}, sysdate, 0)")
	public void noticeBoardInsert(NoticeBoardVO vo);
	
	// 판매자 공지 팝업 업데이트
	public void noticeBoardPopupUpdate(Map map);
	
	public List<NoticeBoardVO> sellerNoticeList(Map map);
	
	// 판매자 공지 COUNT
	@Select("SELECT COUNT(*) FROM noticeboard WHERE userid=#{id}")
	public int sellerNoticeTotalPage(Map map);
	
	// 판매자 공지 상세
	public NoticeBoardVO noticeDetailData(int nbno);
	
	// 공지 조회수 상승
	@Update("UPDATE noticeboard SET hit=hit+1 WHERE nbno=#{nbno}")
	public void noticeHitIncrement(int nbno);
	
	@Update("UPDATE noticeboard SET subject=#{subject}, content=#{content} WHERE wbno=#{wbno}")
	public void noticeUpdate(NoticeBoardVO vo);
	
	@Select("SELECT MAX(nbno) FROM noticeboard")
	public int noticeGetNum();
}
