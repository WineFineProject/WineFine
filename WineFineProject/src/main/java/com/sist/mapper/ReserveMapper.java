package com.sist.mapper;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
public interface ReserveMapper {
	// 예약 신청
	@Insert("INSERT INTO wine_reserve(rno,weno,userid,person,regdate) "
			 +"VALUES(wr_rno_seq.nextval,#{weno},#{userid},#{person},SYSDATE)")
	public void reserveInsert(ReserveVO vo);
	// 예약 인원
	@Select("SELECT SUM(person) FROM wine_reserve WHERE weno=#{weno}")
	public int reservePerson(ReserveVO vo);
	
}
