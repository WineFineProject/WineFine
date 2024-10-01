package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class PromotionCouponVO {
	private int pcno, discount, type, target, state;
	private String title, userid, startDay, endDay;
	private Date startdate, enddate;
}
