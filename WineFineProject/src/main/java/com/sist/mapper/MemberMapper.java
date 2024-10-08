package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
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
	
	// �쉶�썝 紐⑸줉 議고쉶
    @Select("SELECT id, nickname, name, TO_CHAR(birthdate, 'YYYY-MM-DD') as dbbirthday, sex, phone, post, addr1, addr2, grade, photo, admin, TO_CHAR(regdate, 'YYYY-MM-DD') as dbregdate, email "
    		+"FROM member WHERE admin=0 " 
            +"ORDER BY regdate DESC")
    public List<MemberVO> memberList();
    
    // 愿�由ъ옄 �쉶�썝 紐⑸줉 議고쉶
    @Select("SELECT id, nickname, name, TO_CHAR(birthdate, 'YYYY-MM-DD') as dbbirthday, sex, phone, post, addr1, addr2, grade, photo, admin, TO_CHAR(regdate, 'YYYY-MM-DD') as dbregdate, email "
    		+"FROM member WHERE admin IN (0, 2) " 
            +"ORDER BY regdate DESC")
    public List<MemberVO> adminmemberList();

    // �쉶�썝 �궘�젣
    @Delete("DELETE FROM member WHERE id=#{id}")
    public void deleteMember(String id);

    // �쉶�썝 �긽�꽭 議고쉶
    @Select("SELECT id, nickname, name, TO_CHAR(birthdate, 'YYYY-MM-DD') as dbbirthday, sex, phone,"
    		+"post, addr1, addr2, grade, photo, admin, TO_CHAR(regdate, 'YYYY-MM-DD') as dbregdate, email "
    		+"FROM member WHERE id=#{id}")
    public MemberVO memberDetail(String id);

    // �쉶�썝 �젙蹂� �닔�젙
    @Update("UPDATE member SET nickname=#{nickname}, name=#{name}, phone=#{phone}," 
            +"addr1=#{addr1}, addr2=#{addr2}, email=#{email} WHERE id=#{id}")
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
  	
  	@Select("SELECT userId, userName, userPwd, sex, email, phone, post, addr1, addr2 "
  			+ "FROM wine_member "
  			+ "WHERE userId=#{userId}")
  	public MemberVO memberSessionData(String userId);
}