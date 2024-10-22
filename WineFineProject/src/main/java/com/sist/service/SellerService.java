package com.sist.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface SellerService {
	public List<Integer> sellerVisitWeeks(String pageid);
	public int sellerVisitMax(String pageid);
}
