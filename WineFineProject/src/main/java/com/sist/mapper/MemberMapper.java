package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface MemberMapper {
	// 회원 아이디 확인
	@Select("SELECT COUNT(*) FROM member WHERE id=#{id}")
    public int memberCountId(String id);
	@Select("SELECT COUNT(*) FROM wine_member WHERE userId=#{userId}")
	public int memberIdCheck(String userId);
	
	// 회원 비밀번호 찾기
	@Select("SELECT pwd FROM member WHERE id=#{id}")
	public String memberGetPwd(String id);
	@Select("SELECT userId, userName, userPwd, enabled FROM wine_member WHERE userId=#{userId}")
	public MemberVO memberInfo(String userId);
	
	// 회원 닉네임 중복체크
	@Select("SELECT COUNT(*) FROM wine_member WHERE nickname=#{nickName}")
	public int memberNickCheck(String nickName);
	
	// 회원 이메일 중복체크
	@Select("SELECT COUNT(*) FROM wine_member WHERE email=#{eamil}")
	public int memberEmailCheck(String email);
	
	// 회원 전화번호 중복체크
	@Select("SELECT COUNT(*) FROM wine_member WHERE phone=#{phone}")
	public int memberPhoneCheck(String phone);
	
	// 회원 목록 조회
    @Select("SELECT id, nickname, name, TO_CHAR(birthdate, 'YYYY-MM-DD') as dbbirthday, sex, phone, post, addr1, addr2, grade, photo, admin, TO_CHAR(regdate, 'YYYY-MM-DD') as dbregdate, email "
    		+"FROM member WHERE admin=0 " 
            +"ORDER BY regdate DESC")
    public List<MemberVO> memberList();
    
    // 관리자 회원 목록 조회
    @Select("SELECT id, nickname, name, TO_CHAR(birthdate, 'YYYY-MM-DD') as dbbirthday, sex, phone, post, addr1, addr2, grade, photo, admin, TO_CHAR(regdate, 'YYYY-MM-DD') as dbregdate, email "
    		+"FROM member WHERE admin IN (0, 2) " 
            +"ORDER BY regdate DESC")
    public List<MemberVO> adminmemberList();

    // 회원 삭제
    @Delete("DELETE FROM member WHERE id=#{id}")
    public void deleteMember(String id);

    // 회원 상세 조회
    @Select("SELECT id, nickname, name, TO_CHAR(birthdate, 'YYYY-MM-DD') as dbbirthday, sex, phone,"
    		+"post, addr1, addr2, grade, photo, admin, TO_CHAR(regdate, 'YYYY-MM-DD') as dbregdate, email "
    		+"FROM member WHERE id=#{id}")
    public MemberVO memberDetail(String id);

    // 회원 정보 수정
    @Update("UPDATE member SET nickname=#{nickname}, name=#{name}, phone=#{phone}," 
            +"addr1=#{addr1}, addr2=#{addr2}, email=#{email} WHERE id=#{id}")
    public void updateMember(MemberVO member);
    
    
}