package com.sist.vo;
/*
WRENO		NUMBER
USERID		VARCHAR2(100 BYTE)
TYPE		NUMBER
TNO			NUMBER
STATE		NUMBER(10,0)
RID			VARCHAR2(100 BYTE)
REGDATE		DATE
CONTENT		CLOB
CATEGORY	VARCHAR2(100 BYTE)
 */
import java.util.*;
import lombok.Data;
@Data
public class Wine_ReportVO {
	private int wreno, type, tno, state, count1, count2, count3, count4;
	private String userid, rid, category,content, dbday;
	private Date regdate;
	private BoardVO bvo=new BoardVO();
	private BoardReplyVO brvo=new BoardReplyVO();
	private WineVO wvo=new WineVO();
	private WineReviewVO wrvo=new WineReviewVO();
}
