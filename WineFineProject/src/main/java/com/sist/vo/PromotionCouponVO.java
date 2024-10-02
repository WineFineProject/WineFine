package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class PromotionCouponVO {
	private int pcno, discount, type, target, state;
	private String title, userid, startDay, endDay, targetname;
	private Date startdate, enddate;
	private WineVO wvo=new WineVO();
	private MemberVO mvo=new MemberVO();
}
