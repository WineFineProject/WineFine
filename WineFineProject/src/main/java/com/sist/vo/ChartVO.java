package com.sist.vo;

import lombok.Data;

@Data
public class ChartVO {
	int price, account, payment, count;
	String type, addr, dbday, range;
}
