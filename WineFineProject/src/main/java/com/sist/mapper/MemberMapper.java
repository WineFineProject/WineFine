package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface MemberMapper {
	// �쉶�썝 �븘�씠�뵒 �솗�씤
	@Select("SELECT COUNT(*) FROM member WHERE id=#{id}")
    public int memberCountId(String id);
	@Select("SELECT COUNT(*) FROM wine_member WHERE userId=#{userId}")
	public int memberIdCheck(String userId);
	
	// �쉶�썝 鍮꾨�踰덊샇 李얘린
	@Select("SELECT pwd FROM member WHERE id=#{id}")
	public String memberGetPwd(String id);
	
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
    @Select("SELECT wm.userId, wm.nickName, wm.userName, birthday, wm.sex, wm.phone, wm.post, wm.addr1, wm.addr2, wm.grade, wm.photo, "
    		+"a.authority, TO_CHAR(wm.regdate, 'YYYY-MM-DD') as regday, wm.email "
    		+"FROM wine_member wm "
    		+"JOIN authority a ON wm.userid = a.userid "
    		+"WHERE a.authority = 'ROLE_USER' "
    		+"ORDER BY wm.regdate DESC")
    public List<MemberVO> memberList();
    
    // 관리자 회원 목록
    @Select("SELECT userId, nickName, userName, birthday, sex, phone, post, addr1, addr2, grade, photo,"
    		+ "authority, regday, email "
    		+ "FROM (SELECT wm.userId, wm.nickName, wm.userName, birthday, wm.sex, wm.phone, wm.post,"
    		+ "wm.addr1, wm.addr2, wm.grade, wm.photo,"
    		+ "a.authority, TO_CHAR(wm.regdate, 'YYYY-MM-DD') as regday, wm.email,"
    		+ "rownum as num "
    		+ "FROM wine_member wm "
    		+ "JOIN authority a ON wm.userid = a.userid "
    		+ "WHERE a.authority IN ('ROLE_USER', 'ROLE_SELLER') "
    		+ "ORDER BY wm.regdate DESC) "
    		+ "WHERE num BETWEEN #{start} AND #{end}")
    public List<MemberVO> adminmemberList(@Param("start") int start, @Param("end") int end);
    
    // 관리자 회원 목록 페이징
    @Select("SELECT CEIL(COUNT(*) / 10.0) FROM wine_member")
    public int adminmemberCount();

    // 회원 삭제
    @Delete("DELETE FROM wine_member WHERE userId=#{userId}")
    public void deleteMember(String id);

    // 회원 상세보기
    @Select("SELECT userId, nickName, userName, birthday, sex, phone, post, addr1, addr2, grade, photo, point, "
    		+"TO_CHAR(regdate, 'YYYY-MM-DD') as regday, email "
    		+"FROM wine_member WHERE userId=#{userId}")
    public MemberVO memberDetail(String id);

    // 회원 수정
    @Update("UPDATE wine_member SET nickName=#{nickName}, userName=#{userName}, phone=#{phone}," 
            +"addr1=#{addr1}, addr2=#{addr2}, email=#{email} WHERE userId=#{userId}")
    public void updateMember(MemberVO member);
    
    // 멤버 등록
    @Insert("INSERT INTO wine_member (userid, username, userpwd, sex, birthday, email, post, addr1, addr2, phone, nickname) "
    		+ "VALUES(#{userId}, #{userName}, #{userPwd}, #{sex}, #{birthday}, #{email}, #{post}, #{addr1}, #{addr2}, #{phone}, #{nickName})")
    public void insertMember(MemberVO vo);
    
    // 멤버 권한
    @Insert("INSERT INTO authority VALUES(#{userId}, 'ROLE_USER')")
    public void insertAuthority(String userId);
    
    @Select("SELECT userId, userName, userPwd, enabled, authority FROM wine_member sm JOIN authority au ON sm.userId=au.userId AND pm.userId=#{userId}")
  	public MemberVO memberInfo(String userId);
  	
  	@Select("SELECT userId, userName, userPwd, sex, email, phone, post, addr1, addr2, nickName "
  			+ "FROM wine_member "
  			+ "WHERE userId=#{userId}")
  	public MemberVO memberSessionData(String userId);
}