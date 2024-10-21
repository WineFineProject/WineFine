package com.sist.vo;

import lombok.Data;

@Data
public class CartVO {
	private int cno, wno, account;
	private String userId, dbday;
	private WineVO wvo=new WineVO();


}
