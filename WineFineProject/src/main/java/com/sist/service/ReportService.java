package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.Wine_ReportVO;

public interface ReportService {
	public List<Wine_ReportVO> reportListData(Map map);
	public int reportListCount();
	public Wine_ReportVO reportBoardData(int wreno);
	public Wine_ReportVO reportReplyData(int wreno);
	public Wine_ReportVO reportWineData(int wreno);
	public Wine_ReportVO reportReviewData(int wreno);
	public void reportState(int wreno);
}
