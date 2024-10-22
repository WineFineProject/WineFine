package com.sist.vo;

import lombok.Data;

@Data
public class DeliveryVO {
	private int wdno, state;
	private String name, userId, post, addr1, addr2, msg, addrEng;
}
