package com.sist.vo;

import lombok.Data;

@Data
public class CartVO {
	private int cno, wno, price, count;
	private WineVO wine;
	private String id; // memberVO id

	// private List<SellerGroupVO> sellerGroups;
	//private int totalCount;
	//idprivate int totalPrice;

}
