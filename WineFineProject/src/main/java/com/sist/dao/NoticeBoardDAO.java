package com.sist.dao;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.*;
import java.util.*;

@Repository
public class NoticeBoardDAO {
	@Autowired
	private NoticeBoardMapper mapper;

	public void noticeBoardInsert(NoticeBoardVO vo) {
		mapper.noticeBoardInsert(vo);
	}
	
	public void noticeBoardPopupUpdate(Map map) {
		mapper.noticeBoardPopupUpdate(map);
	}

	public List<NoticeBoardVO> sellerNoticeList(Map map) {
		return mapper.sellerNoticeList(map);
	}

	public int sellerNoticeTotalPage(Map map) {
		return mapper.sellerNoticeTotalPage(map);
	}

	public NoticeBoardVO noticeDetail(int nbno) {
		mapper.noticeHitIncrement(nbno);
		return mapper.noticeDetailData(nbno);
	}
	public NoticeBoardVO noticeDetailData(int nbno) {
		return mapper.noticeDetailData(nbno);
	}

	public void noticeBoardUpdate(NoticeBoardVO vo) {
		mapper.noticeUpdate(vo);
	}
	public int noticeGetNum() {
		return mapper.noticeGetNum();
	}
	
	public void noticeDelete(int nbno) {
		mapper.wineNoticeDelete(nbno);
		mapper.noticeDelete(nbno);
	}
}
