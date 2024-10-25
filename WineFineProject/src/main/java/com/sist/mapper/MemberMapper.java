package com.sist.mapper;

import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface MemberMapper {
	// �쉶�썝 �븘�씠�뵒 �솗�씤
	@Select("SELECT COUNT(*) FROM member WHERE id=#{id}")
	public int memberCountId(String id);

	@Select("SELECT COUNT(*) FROM wine_member WHERE userId=#{userId}")
	public int memberIdCheck(String userId);

	// 비밀번호 확인
	@Select("SELECT userpwd FROM wine_member WHERE userId=#{userId}")
	public String memberGetPwd(String userId);

	// �쉶�썝 �땳�꽕�엫 以묐났泥댄겕
	@Select("SELECT COUNT(*) FROM wine_member WHERE nickname=#{nickName}")
	public int memberNickCheck(String nickName);

	// �쉶�썝 �씠硫붿씪 以묐났泥댄겕
	@Select("SELECT COUNT(*) FROM wine_member WHERE email=#{eamil}")
	public int memberEmailCheck(String email);

	// �쉶�썝 �쟾�솕踰덊샇 以묐났泥댄겕
	@Select("SELECT COUNT(*) FROM wine_member WHERE phone=#{phone}")
	public int memberPhoneCheck(String phone);

	// 회원 목록
	@Select("SELECT userId, nickName, userName, birthday, sex, phone, post, addr1, addr2, grade, photo, point, "
			+ "authority, regday, TO_CHAR(lastlogin, 'YYYY-MM-DD HH24:MI:SS') as lastloginday, email, num "
			+ "FROM (SELECT wm.userId, wm.nickName, wm.userName, wm.birthday, wm.sex, wm.phone, wm.post, wm.addr1, wm.addr2, wm.grade, wm.photo, wm.point, "
			+ "a.authority, TO_CHAR(wm.regdate, 'YYYY-MM-DD') as regday, wm.lastlogin, email, rownum as num "
			+ "FROM wine_member wm " + "JOIN authority a ON wm.userId=a.userId " + "WHERE a.authority='ROLE_USER' "
			+ "ORDER BY wm.regdate DESC) " + "WHERE num BETWEEN #{start} AND #{end}")
	public List<MemberVO> memberList(@Param("start") int start, @Param("end") int end);

	// 회원 목록 페이징
	@Select("SELECT CEIL(COUNT(*) / 10.0) FROM wine_member JOIN authority ON wine_member.userId=authority.userId WHERE authority='ROLE_USER'")
	public int memberCount();

	// 관리자 회원 목록
	@Select("SELECT userId, nickName, userName, birthday, sex, phone, post, addr1, addr2, grade, photo, point,"
			+ "authority, regday,  TO_CHAR(lastlogin, 'YYYY-MM-DD HH24:MI:SS') as lastloginday, email, num "
			+ "FROM (SELECT wm.userId, wm.nickName, wm.userName, birthday, wm.sex, wm.phone, wm.post,"
			+ "wm.addr1, wm.addr2, wm.grade, wm.photo, wm.point,"
			+ "a.authority, TO_CHAR(wm.regdate, 'YYYY-MM-DD') as regday, wm.lastlogin, wm.email," + "rownum as num "
			+ "FROM wine_member wm " + "JOIN authority a ON wm.userid = a.userid "
			+ "WHERE a.authority IN ('ROLE_USER', 'ROLE_SELLER') " + "ORDER BY wm.regdate DESC) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<MemberVO> adminmemberList(@Param("start") int start, @Param("end") int end);

	// 관리자 회원 목록 페이징
	@Select("SELECT CEIL(COUNT(*) / 10.0) FROM wine_member JOIN authority ON wine_member.userId=authority.userId WHERE authority IN ('ROLE_USER', 'ROLE_SELLER')")
	public int adminmemberCount();

	// 관리자 회원 등급 조정
	@Update("UPDATE wine_member SET " + "grade=grade+1 " + "WHERE userId=#{userId}")
	public void gradeIncrement(String userId);

	@Update("UPDATE wine_member SET " + "grade=grade-1 " + "WHERE userId=#{userId}")
	public void gradeDecrement(String userId);

	// 회원 삭제
	@Delete("DELETE FROM wine_member WHERE userId=#{userId}")
	public void deleteMember(String id);

	// 회원 상세보기
	@Select("SELECT userId, nickName, userName, birthday, sex, phone, post, addr1, addr2, grade, photo, point, "
			+ "TO_CHAR(regdate, 'YYYY-MM-DD') as regday, email " + "FROM wine_member WHERE userId=#{userId}")
	public MemberVO memberDetail(String id);

	// 판매자 가입 대기
	@Select("SELECT userId, nickName, userName, birthday, phone, post, addr1, addr2, photo, "
			+ "TO_CHAR(regdate, 'YYYY-MM-DD') as regday, email " + "FROM wine_member WHERE state=1")
	public List<MemberVO> memberWait();

	// 판매자 가입 승인
	@Update("UPDATE wine_member SET state=0 WHERE userId=#{userId}")
	public void accessMember(String id);

	// 판매자 가입 거절
	@Delete("DELETE FROM wine_member WHERE userId=#{userId}")
	public void noAccessMember(String id);

	// 회원 수정
	@Update("UPDATE wine_member SET nickName=#{nickName}, userName=#{userName}, phone=#{phone},"
			+ "addr1=#{addr1}, addr2=#{addr2}, email=#{email} WHERE userId=#{userId}")
	public void updateMember(MemberVO member);

	// 멤버 등록
	@Insert("INSERT INTO wine_member (userid, username, userpwd, sex, birthday, email, post, addr1, addr2, phone, nickname, state) "
			+ "VALUES(#{userId}, #{userName}, #{userPwd}, #{sex}, #{birthday}, #{email}, #{post}, #{addr1}, #{addr2}, #{phone}, #{nickName}, #{state})")
	public void insertMember(MemberVO vo);

	// 멤버 권한
	@Insert("INSERT INTO authority VALUES(#{userId}, 'ROLE_USER')")
	public void insertAuthority(String userId);

	@Select("SELECT userId, userName, userPwd, enabled, authority FROM wine_member sm JOIN authority au ON sm.userId=au.userId AND pm.userId=#{userId}")
	public MemberVO memberInfo(String userId);

	@Select("SELECT m.userId, userName, userPwd, sex, email, phone, post, addr1, addr2, nickName, authority " + "FROM wine_member m JOIN authority a ON a.userid=m.userid "
			+ "WHERE m.userId=#{userId}")
	public MemberVO memberSessionData(String userId);

	// 비밀번호 변경
	@Update("UPDATE wine_member SET userpwd=#{userpwd} WHERE userId=#{userid}")
	public void updatePwd(@Param("userid") String userid,@Param("userpwd") String userpwd);
	
	// 최근 로그인
	@Update("UPDATE wine_member SET lastlogin=sysdate WHERE userId=#{userId}")
	public void memberLastLogin(String userId);

	@Insert("INSERT INTO wine_visit VALUES((SELECT NVL(MAX(vno)+1, 1) FROM wine_visit), sysdate, #{pageid})")
	public void visitCheck(String pageid);

	@Update("UPDATE authority SET authority='ROLE_SELLER' WHERE userId=#{userId}")
	public void sellerAuthority(MemberVO vo);
}