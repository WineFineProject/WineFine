package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.NoticeBoardVO;

public interface NoticeBoardService {
	public void noticeBoardInsert(NoticeBoardVO vo);
	public List<NoticeBoardVO> sellerNoticeList(Map map);
	public int sellerNoticeTotalPage(Map map);
}
