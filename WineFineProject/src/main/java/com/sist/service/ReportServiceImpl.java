package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.ReportDAO;
import com.sist.vo.Wine_ReportVO;

@Service
public class ReportServiceImpl implements ReportService{
    @Autowired
    private ReportDAO dao;

	@Override
	public List<Wine_ReportVO> reportListData(int start, int end) {
		// TODO Auto-generated method stub
		return dao.reportListData(start, end);
	}

	@Override
	public int reportListCount() {
		// TODO Auto-generated method stub
		return dao.reportListCount();
	}

	@Override
	public Wine_ReportVO reportBoardData(int wreno) {
		// TODO Auto-generated method stub
		return dao.reportBoardData(wreno);
	}

	@Override
	public Wine_ReportVO reportReplyData(int wreno) {
		// TODO Auto-generated method stub
		return dao.reportReplyData(wreno);
	}

	@Override
	public Wine_ReportVO reportWineData(int wreno) {
		// TODO Auto-generated method stub
		return dao.reportWineData(wreno);
	}

	@Override
	public Wine_ReportVO reportReviewData(int wreno) {
		// TODO Auto-generated method stub
		return dao.reportReviewData(wreno);
	}
}
