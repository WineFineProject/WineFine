package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AccVO {
	private int acno, amount, fee, vat, state;
	private String userid, grade, rdbday, edbday;
	private Date regdate, enddate;
}
