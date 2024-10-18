package com.sist.mapper;
import com.sist.vo.*;

import java.util.*;

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
	
	// 예약 일정 불러오기
	@Select("SELECT e.title,e.eventdate,e.address,r.userid,r.person "
			+"FROM wine_event JOIN wine_reserve r ON e.weno = r.weno "
			+"WHERE r.userid = #{userid}")
	public List<EventVO> getReserveEvent(ReserveVO vo);
}
