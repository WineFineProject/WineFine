package com.sist.service;

import java.util.List;

import com.sist.vo.NoticeBoardVO;
import com.sist.vo.NoticeVO;
import com.sist.vo.WineReturnVO;

public interface NoticeService {
	public void noticeInsert(NoticeVO vo);
	public List<NoticeVO> noticeNewListData(String id);
	public int noticeNewCount(String id);
	public List<NoticeVO> noticeOldListData(String id);
	public void noticeStateUpdate(int nno);
	public void returnRequestInsert(WineReturnVO vo);
}
