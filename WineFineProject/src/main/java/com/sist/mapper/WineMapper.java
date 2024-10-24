package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface WineMapper {
	//���� ��� ���
	public List<WineVO> wineListData2(Map map);
	public int wineTotalCount(Map map);
	
	//���� �˻� ��� ���
	public List<WineVO> wineFindList(Map map);
	
	//���� ������ ���
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM wine")
	public int wineTotalPage();

	public List<WineVO> wineFindData(String fd);
	public int wineFindCount(String fd);
	public List<WineVO> adminWineList(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM wine WHERE state=9")
	public int adminWinePage();
	
	public List<Wine_PaymentVO> myPaymentList(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM wine_payment WHERE userid=#{userId}")
	public int myPaymentTotalPage(Map map);
	
	@Select("SELECT seller FROM wine WHERE wno=#{wno}")
	public String getSeller(int wno);
	
	@Update("UPDATE wine_payment SET state=1 WHERE trunc(regdate)+1=trunc(sysdate) AND state!=1 AND state<7")
	public void paymentStateUpdate1();
	@Update("UPDATE wine_payment SET state=2 WHERE trunc(regdate)+2=trunc(sysdate) AND state!=2 AND state<7")
	public void paymentStateUpdate2();
	@Update("UPDATE wine_payment SET state=3 WHERE trunc(regdate)+4=trunc(sysdate) AND state!=3 AND state<7")
	public void paymentStateUpdate3();
	@Results({
		@Result(property = "wvo.seller", column = "seller")
	})
	@Select("SELECT wp.wno, wp.account, wp.payment, w.seller FROM wine_payment wp JOIN wine w ON wp.wno=w.wno WHERE trunc(wp.regdate)+2=trunc(sysdate) AND wp.state!=2 AND wp.state!=7")
	public List<Wine_PaymentVO> paymentGetAccount();
	@Update("UPDATE wine SET stack=stack-#{account} WHERE wno=#{wno}")
	public void wineStackUpdate(Wine_PaymentVO vo);
	@Update("UPDATE wine_member SET point=point+#{payment} WHERE userid=#{wvo.seller}")
	public void sellerAccUpdate(Wine_PaymentVO vo);
	
	@Update("UPDATE wine_payment SET state=7 WHERE wpno=#{wpno}")
	public void paymentReturnReques(int wpno);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM winelike WHERE id=#{userid}")
	public int myLikeTotalPage(Map map);
	public List<LikeVO> myLikeList(Map map);
	
	@Delete("DELETE FROM winelike WHERE lno=#{lno}")
	public void likeDelete(int rno);
	
	// 신고페이지 와인 삭제
	@Update("UPDATE wine SET state=7 WHERE wno=#{wno}")
	public void reportWineUpdate(int wno);
		
	public Map<String, Integer> sellerHomeSaleInfo(String userid);
	public Map<String, Integer> sellerHomeWineInfo(String userid);
}
