package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.AccVO;


public interface AdminMapper {
	public List<Integer> visitWeeks();
	
	@Select("SELECT max(count(*)) FROM wine_visit WHERE trunc(visitdate) BETWEEN trunc(sysdate-6) AND trunc(sysdate) AND pageid='home' GROUP BY trunc(visitdate)")
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
	@Select("SELECT acno, userid, amount, fee, vat, state, grade, TO_CHAR(regdate,'YYYY-MM-DD') as rdbday, "
			+ "CASE "
			+ "		WHEN enddate IS NULL THEN '-' "
			+ "		ELSE TO_CHAR(enddate, 'YYYY-MM-DD') "
			+ "END as edbday "
			+ "FROM wine_acc WHERE state = 0 ")
	public List<AccVO> accList();
	@Update("UPDATE wine_acc SET state=#{state}, enddate=sysdate WHERE acno=#{acno}")
	public void accUpdate(@Param("state") int state, @Param("acno") int acno);
}
