package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PromotionBannerVO {
	private int pbno, stack, wno, type, state;
	private String title,userid, startDay, endDay;
	private Date startdate, enddate;
	private WineVO wvo=new WineVO();
	private MemberVO mvo=new MemberVO();
}
