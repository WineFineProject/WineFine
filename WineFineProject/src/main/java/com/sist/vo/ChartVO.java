package com.sist.vo;

import lombok.Data;

@Data
public class ChartVO {
	int price, account, payment, count, saleprice, salecount, salepayment, saleaccount, visit;
	String type, addr, dbday, range, period;
}
