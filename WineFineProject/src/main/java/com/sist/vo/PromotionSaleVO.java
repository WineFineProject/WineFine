package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PromotionSaleVO {
	private int psno, discount, type, target, state;
	private String title, userid, startDay, endDay;
	private Date enddate, startdate;
	private WineVO wvo=new WineVO();
	private MemberVO mvo=new MemberVO();
	private String targetname;
}
