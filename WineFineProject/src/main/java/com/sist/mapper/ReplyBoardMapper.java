package com.sist.mapper;

import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ReplyBoardMapper {
//	총 갯수
	@Select("SELECT CEIL (COUNT(*)) FROM wine_replyboard WHERE type = 1")
	public int shopReplyTotalPage();
	
	// shop목록
	@Select("SELECT wrno,userid,nickname,subject, TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret,num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret,rownum as num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret "
			+ "FROM wine_replyboard WHERE type =1 ORDER BY group_id DESC , group_step ASC)) "
			+ "WHERE rownum <= #{count} AND wno = #{wno} ")
	public List<ReplyBoardVO> shopReplyListData(@Param("count")int count, @Param("userid") String userid ,
			@Param("wno")int wno);
	// 목록
	@Select("SELECT wrno,userid,nickname,subject," + "TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret,num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret,rownum as num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret "
			+ "FROM wine_replyboard WHERE type!=1 ORDER BY group_id DESC , group_step ASC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyBoardVO> replyListData(@Param("start") int start, @Param("end") int end,
			@Param("userid") String userid);

	// 판매자 목록
	@Select("SELECT wrno,userid,nickname,subject," + "TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content, num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content, rownum as num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content "
			+ "FROM wine_replyboard WHERE type=1 AND recvid=#{userid} ORDER BY group_id DESC , group_step ASC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyBoardVO> sellrReplyListData(Map map);

	// 관리자 목록
	@Select("SELECT wrno,userid,nickname,subject," + "TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content, num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content, rownum as num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content "
			+ "FROM wine_replyboard WHERE type!=1 AND group_step=0 ORDER BY group_id DESC , group_step ASC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyBoardVO> adminReplyListData(Map map);

	@Select("SELECT COUNT(*) FROM wine_replyboard WHERE type=1 AND recvid=#{userid}")
	public int sellerReplyCount(String userid);

	@Select("SELECT COUNT(*) FROM wine_replyboard WHERE type!=1 AND group_step=0")
	public int replyCount();
	
	@Select("SELECT COUNT(*) FROM wine_replyboard WHERE type =1 AND group_step=0")
	public int shopReplyCount();

	// 작성
	@Insert("INSERT INTO wine_replyboard(wrno, userid, nickname, subject, content, regdate, cno, type, recvid, wno, "
			+ "group_id, group_step, isreply, secret) " + "VALUES((SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), "
			+ "#{userid}, #{nickname}, #{subject}, #{content}, SYSDATE, #{cno}, #{type}, #{recvid}, #{wno}, "
			+ "(SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), #{group_step}, 0, #{secret})")
	public void replyInsert(ReplyBoardVO vo);

	// 판매자 답변글 작성
	@Insert("INSERT INTO wine_replyboard(wrno, userid, nickname, subject, content, type, recvid, wno, group_id, group_step, secret, cno) "
			+ "VALUES((SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), #{userid}, #{nickname}, #{subject}, #{content}, #{type}, #{recvid}, #{wno}, #{group_id}, 1, #{secret}, #{cno})")
	public void sellerReplyInsert(ReplyBoardVO vo);

	// 질문급 답변 상태
	@Update("UPDATE wine_replyboard SET isreply=#{isreply} WHERE wrno=#{wrno}")
	public void replyStateUpdate(@Param("isreply") int isreply, @Param("wrno") int wrno);

	// 조회수
	@Update("UPDATE wine_replyboard SET " + "hit = hit+1 " + "WHERE wrno=#{wrno}")
	public void hitIncrement(int wrno);

	// 상세보기
	public ReplyBoardVO replyDetailData(int wrno);

	// 답변 상세보기
	public ReplyBoardVO replyAnswerDetailData(int group_id);

	// 삭제
	@Delete("DELETE FROM wine_replyboard WHERE group_id=#{group_id}")
	public void replyDelete(int group_id);

	// 답변 삭제
	@Delete("DELETE FROM wine_replyboard WHERE wrno=#{wrno}")
	public void replyAnswerDelete(int wrno);

	@Update("UPDATE wine_replyboard SET isreply=0 WHERE group_id=(SELECT group_id FROM wine_replyboard WHERE wrno=#{wrno})")
	public void replyQuestStateUpdate(int wrno);

	// 수정
	@Update("UPDATE wine_replyboard SET subject=#{subject}, content=#{content}, cno=#{cno}, secret=#{secret} "
			+ "WHERE wrno=#{wrno}")
	public void replyUpdateData(ReplyBoardVO vo);

	@Update("UPDATE wine_replyboard SET subject=#{subject}, content=#{content} WHERE wrno=#{wrno}")
	public void sellerReplyUpdate(ReplyBoardVO vo);

}
