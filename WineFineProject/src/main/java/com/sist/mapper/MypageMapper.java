package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.vo.*;


public interface MypageMapper {
	
	// 개인 정보 불러오기
	@Select("SELECT * FROM wine_member WHERE userId=#{userId}")
	public MemberVO	getMyId(@Param("userId") String userId);
	@Select("SELECT userPwd FROM wine_member WHERE userId=#{userId}")
	public String memberGetPwd(@Param("userId") String userId);
	
	// 중복 체크
	@Select("SELECT COUNT(*) FROM wine_member WHERE nickName=#{nickName} AND userId!=#{userId}")
	public int nickCheck(@Param("nickName") String nickName,@Param("userId") String userId);
	
	@Select("SELECT COUNT(*) FROM wine_member WHERE phone=#{phone} AND userId!=#{userId}")
	public int phoneCheck(@Param("phone") String phone,@Param("userId") String userId);
	
	@Select("SELECT COUNT(*) FROM wine_member WHERE email=#{email} AND userId!=#{userId}")
	public int emailCheck(@Param("email") String email,@Param("userId") String userId);
	
	@Select("SELECT userPwd FROM wine_member WHERE userId=#{userId}")
	public String checkPwd(@Param("userId")String userId);

	// 개인 정보 수정
	@Update("UPDATE wine_member SET nickname=#{nickName},post=#{post},addr1=#{addr1},addr2=#{addr2},phone=#{phone},email=#{email} "
			+ "WHERE userId=#{userId}")
	public void updateMyInfo(MemberVO vo);
	
	
	// 작성 글 목록
	@Select("SELECT bno,id,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, num "
			+"FROM (SELECT bno,id,subject,nickname,regdate, hit, rownum as num "
			+"FROM (SELECT bno,id,subject,nickname,regdate, hit "
	        +"FROM board WHERE id=#{userid} ORDER BY bno DESC)) "
	        +"WHERE num BETWEEN #{start} AND #{end} ")
    public List<BoardVO> myBoardListData(Map map);

	@Select("SELECT wrno,userid,subject,nickname,TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, num "
			+"FROM (SELECT wrno,userid,subject,nickname,regdate, hit, rownum as num "
			+"FROM (SELECT wrno,userid,subject,nickname,regdate, hit "
	        +"FROM wine_replyboard WHERE userid=#{userid} ORDER BY wrno DESC)) "
	        +"WHERE num BETWEEN #{start} AND #{end}")
    public List<ReplyBoardVO> myReplyListData(Map map);
	
	// 총페이지
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM board WHERE id=#{userid}")
	public int myPageBoardTotalPage(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM wine_replyboard WHERE userid=#{userid}")
	public int myReplyTotalPage(Map map);
		 
	// 작성 댓글 목록
	@Select("SELECT brno,bno,id,nickname,msg,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday,root,depth, num "
			+"FROM (SELECT brno,bno,id,nickname,msg,regdate,root,depth, rownum as num "
			+"FROM (SELECT brno,bno,id,nickname,msg,regdate,root,depth "
			+"FROM boardreply WHERE id=#{userid} ORDER BY root DESC, depth ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<BoardReplyVO> myboardReplyListData(Map map);
	
	// 총페이지
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM boardreply WHERE id=#{userid}")
	public int myboardReplyTotalPage(Map map);
	
	//회원 탈퇴
	
	//예약내역 존재 여부 확인
	@Select("SELECT COUNT(*) FROM wine_reserve WHERE userid=#{userid}")
	public int myreservecount(String userid);
	
	//게시판 닉네임 바꾸기(게시글, 댓글)
	@Update("UPDATE board SET nickname='탈퇴회원' WHERE id=#{userid} ")
	public void bchangenick(String userid);
	@Update("UPDATE boardreply SET nickname='탈퇴회원' WHERE id=#{userid} ")
	public void brchangenick(String userid);
	
	//리뷰 삭제 
	@Delete("DELETE FROM wine_review WHERE userid=#{userid} ")
	public void reviewdelete(String userid);
	
	//좋아요 삭제
	@Delete("DELETE FROM winelike WHERE id=#{userid} ")
	public void likedelete(String userid);
	
	//예약 내역 삭제
	@Delete("DELETE FROM wine_reserve WHERE userid=#{userid} ")
	public void reservedelete(String userid);
	
	//비밀번호 확인용 원래 비밀번호
	@Select("SELECT userpwd FROM wine_member WHERE userid=#{userid} ")
	public String pwdCheck(String userid);
	
	//비밀번호 및 회원정보 초기화
	@Update("UPDATE wine_member SET userpwd='cancel', username='탈퇴회원', nickname='탈퇴회원', sex='-', "
			+ "enabled=0, birthday=sysdate, email='-', post='-', addr1='-', addr2='-', "
			+ " phone='-', photo='-', point=0 "
			+ " WHERE userId=#{userId}")
	public void pwdcancel(String userid);
	
	//진행중인 주문 수 확인
	@Select("SELECT COUNT(*) FROM wine_payment WHERE userid=#{userid} AND state < 3 ")
	public int ingpaycount(String userid);
	
	//권한 변경
	@Update("UPDATE authority SET authority='ROLE_CANCEL' WHERE userId=#{userId}")
	public void Authorityupdate(String userid);
	 
}

