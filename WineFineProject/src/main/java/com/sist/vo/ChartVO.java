package com.sist.vo;

import lombok.Data;

@Data
public class ChartVO {
	int price, account, payment, count, saleprice, salecount, salepayment;
	String type, addr, dbday, range, period;
}
