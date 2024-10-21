package com.sist.vo;
/*
WRVNO	NUMBER
WNO	NUMBER
USERID	VARCHAR2(50 BYTE)
SRATING	NUMBER
REGDATE	DATE
NICKNAME	VARCHAR2(50 BYTE)
CONTENT	CLOB
 */
import java.util.*;

import lombok.Data;
@Data
public class WineReviewVO {
	private int wrvno, wno, srating, totalRating, reviewCount;
	private String userid, nickname, content, dbday;
	private Date regdate;
	private WineVO wvo=new WineVO();
}
