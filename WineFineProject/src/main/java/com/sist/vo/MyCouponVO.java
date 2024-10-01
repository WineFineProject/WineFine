package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class MyCouponVO {
	private int pcno, discount, state;
	private String title, recvid, startDay, endDay, pcid;
	private Date startdate, enddate;
	private WineVO wvo=new WineVO();
	private PromotionCouponVO pvo=new PromotionCouponVO();
}
