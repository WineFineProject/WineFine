package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;


public interface AdminMapper {
	public List<Integer> visitWeeks();
	
	@Select("SELECT max(count(*)) FROM wine_visit WHERE trunc(visitdate) BETWEEN trunc(sysdate-6) AND trunc(sysdate) GROUP BY trunc(visitdate)")
	public int visitMax();
	
	@Select("SELECT COUNT(*) FROM promotion_coupon WHERE state=0")
	public int noneCoupon();
	@Select("SELECT COUNT(*) FROM promotion_sale WHERE state=0")
	public int noneSale();
	@Select("SELECT COUNT(*) FROM promotion_banner WHERE state=0")
	public int noneBanner();
	@Select("SELECT COUNT(*) FROM wine WHERE state=9")
	public int noneItem();
	@Select("SELECT COUNT(*) FROM wine_replyboard WHERE isreply=0 AND group_step=0 AND type!=1")
	public int noneAnswer();
	@Select("SELECT COUNT(*) FROM wine_payment WHERE trunc(sysdate)=trunc(regdate)")
	public int nonePayment();
}
