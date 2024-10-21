package com.sist.dao;
import com.sist.mapper.*;
import com.sist.vo.*;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAO {
  @Autowired
  private ReportMapper mapper;
  
  public List<Wine_ReportVO> reportListData(int start, int end)
  {
	  return mapper.reportListData(start, end);
  }
  public int reportListCount()
  {
	  return mapper.reportListCount();
  }
  public Wine_ReportVO reportBoardData(int wreno)
  {
	  return mapper.reportBoardData(wreno);
  }
  public Wine_ReportVO reportReplyData(int wreno)
  {
	  return mapper.reportReplyData(wreno);
  }
  public Wine_ReportVO reportWineData(int wreno)
  {
	  return mapper.reportWineData(wreno);
  }
  public Wine_ReportVO reportReviewData(int wreno)
  {
	  return mapper.reportReviewData(wreno);
  }
}
