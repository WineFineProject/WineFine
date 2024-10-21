package com.sist.service;

import java.util.List;

import com.sist.vo.Wine_ReportVO;

public interface ReportService {
	public List<Wine_ReportVO> reportListData(int start, int end);
	public int reportListCount();
	public Wine_ReportVO reportBoardData(int wreno);
	public Wine_ReportVO reportReplyData(int wreno);
	public Wine_ReportVO reportWineData(int wreno);
	public Wine_ReportVO reportReviewData(int wreno);
}
