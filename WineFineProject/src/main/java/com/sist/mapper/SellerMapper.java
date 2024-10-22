package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface SellerMapper {
	public List<Integer> sellerVisitWeeks(String pageid);
	@Select("SELECT max(count(*)) FROM wine_visit WHERE trunc(visitdate) BETWEEN trunc(sysdate-6) AND trunc(sysdate) AND pageid=#{pageid} GROUP BY trunc(visitdate)")
	public int sellerVisitMax(String pageid);
}
