package com.sist.mapper;
import com.sist.vo.*;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
public interface ReserveMapper {
	// 예약 신청
	@Insert("INSERT INTO wine_reserve(rno,weno,userid,person,regdate) "
			 +"VALUES(wr_rno_seq.nextval,#{weno},#{userid},#{person},SYSDATE)")
	public void reserveInsert(ReserveVO vo);
	// 예약 인원
	@Select("SELECT NVL(SUM(person), 0) FROM wine_reserve WHERE weno=#{weno}")
	public int reservePerson(ReserveVO vo);
	
	// 예약 일정 불러오기
	@Results({
		@Result(property = "evo.title",column = "title"),
		@Result(property = "evo.eday",column = "eday"),
		@Result(property = "evo.address",column = "address")
	})
	@Select("SELECT rno, e.title,TO_CHAR(e.eventdate,'YYYY-MM-DD') as eday,e.address,r.userid,r.person "
			+"FROM wine_event e JOIN wine_reserve r ON e.weno = r.weno "
			+"WHERE r.userid=#{userid}")
	public List<ReserveVO> getReserveEvent(ReserveVO vo);
	
	// 예약 일정 마이페이지용
	@Results({
		@Result(property = "evo.title",column = "title"),
		@Result(property = "evo.eday",column = "eday"),
		@Result(property = "evo.address",column = "address")
	})
	@Select("SELECT rno, title, eday, address, userid, person, dbday, num "
			+ "FROM (SELECT rno, title, eday, address, userid, person, dbday, rownum as num "
			+ "FROM (SELECT rno, e.title,TO_CHAR(e.eventdate,'YYYY-MM-DD') as eday,e.address,r.userid,r.person, TO_CHAR(r.regdate, 'YYYY-MM-DD') as dbday "
			+"FROM wine_event e JOIN wine_reserve r ON e.weno = r.weno "
			+"WHERE r.userid=#{userid} ORDER BY rno DESC)) "
			+ "WHERE NUM BETWEEN #{start} AND #{end}")
	public List<ReserveVO> getMyReserveEvent(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM wine_reserve WHERE userid=#{userid}")
	public int myReserveTotalPage(Map map);
	
	// 예약 상세보기
	@Results({
		@Result(property = "evo.title",column = "title"),
		@Result(property = "evo.eday",column = "eday"),
		@Result(property = "evo.address",column = "address")
	})
	@Select("SELECT rno, e.title,TO_CHAR(e.eventdate,'YYYY-MM-DD') as eday,e.address,r.userid,r.person "
			+"FROM wine_event e JOIN wine_reserve r ON e.weno = r.weno "
			+"WHERE rno=#{rno}")
	public ReserveVO getReserveDetail(int rno);
	
	@Delete("DELETE FROM wine_reserve WHERE rno=#{rno}")
	public void deleteReserve(int rno);
	
	// 메모 추가
	@Insert("INSERT INTO memo(meno,userid,subject,content,startday,endday,bcolor,fcolor) "
			+"VALUES(memo_meno_seq.nextval,#{userid},#{subject},#{content},#{startday},#{endday},#{bcolor},#{fcolor})")
	public void memoInsert(MemoVO vo);
	
	// 메모 목록
	@Select("SELECT * FROM memo WHERE userid=#{userid}")
	public List<MemoVO> memoListData(String userid);
	
	// 메모 상세보기
	@Select("SELECT * FROM memo WHERE meno=#{meno}")
	public MemoVO memoDetailData(int meno);
	
	// 메모 삭제
	@Delete("DELETE FROM memo WHERE meno=#{meno}")
	public void memoDelete(int meno);
	
	
}
