package com.sist.mapper;

import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ReplyBoardMapper {
//	珥� 媛��닔
	@Select("SELECT CEIL (COUNT(*)) FROM wine_replyboard WHERE type = 1")
	public int shopReplyTotalPage();
	
	// shop紐⑸줉
	@Select("SELECT wrno, userid, nickname, subject, TO_CHAR(regdate, 'YYYY-MM-DD') AS dbday, cno, type, "
			+ "     recvid, wno, group_id, group_step, isreply, hit, secret, num "
			+ "FROM (SELECT wrno, userid, nickname, subject, regdate, cno, type,recvid, wno, group_id, group_step, isreply, hit, secret, rownum AS num "
			+ "FROM (SELECT wrno, userid, nickname, subject, regdate, cno, type,recvid, wno, group_id, group_step, isreply, hit, secret "
			+ "FROM wine_replyboard "
			+ "WHERE type = 1 AND wno = #{wno} "
			+ "ORDER BY group_id DESC, group_step ASC) "
			+ "WHERE rownum <= #{count}) ")
	public List<ReplyBoardVO> shopReplyListData(@Param("count")int count, @Param("userid") String userid ,
			@Param("wno")int wno);
	// 紐⑸줉
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

	// �뙋留ㅼ옄 紐⑸줉
	@Select("SELECT wrno,userid,nickname,subject," + "TO_CHAR(regdate,'YYYY-MM-DD') as dbday,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content, num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content, rownum as num "
			+ "FROM (SELECT wrno,userid,nickname,subject,regdate,cno,type,"
			+ "recvid,wno,group_id,group_step,isreply,hit,secret, content "
			+ "FROM wine_replyboard WHERE type=1 AND recvid=#{userid} ORDER BY group_id DESC , group_step ASC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyBoardVO> sellrReplyListData(Map map);

	// 愿�由ъ옄 紐⑸줉
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

	// �옉�꽦
	@Insert("INSERT INTO wine_replyboard(wrno, userid, nickname, subject, content, regdate, cno, type, recvid, wno, "
			+ "group_id, group_step, isreply, secret) " + "VALUES((SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), "
			+ "#{userid}, #{nickname}, #{subject}, #{content}, SYSDATE, #{cno}, #{type}, #{recvid}, #{wno}, "
			+ "(SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), #{group_step}, 0, #{secret})")
	public void replyInsert(ReplyBoardVO vo);

	// �뙋留ㅼ옄 �떟蹂�湲� �옉�꽦
	@Insert("INSERT INTO wine_replyboard(wrno, userid, nickname, subject, content, type, recvid, wno, group_id, group_step, secret, cno) "
			+ "VALUES((SELECT NVL(MAX(wrno)+1, 1) FROM wine_replyboard), #{userid}, #{nickname}, #{subject}, #{content}, #{type}, #{recvid}, #{wno}, #{group_id}, 1, #{secret}, #{cno})")
	public void sellerReplyInsert(ReplyBoardVO vo);

	// 吏덈Ц湲� �떟蹂� �긽�깭
	@Update("UPDATE wine_replyboard SET isreply=#{isreply} WHERE wrno=#{wrno}")
	public void replyStateUpdate(@Param("isreply") int isreply, @Param("wrno") int wrno);

	// 議고쉶�닔
	@Update("UPDATE wine_replyboard SET " + "hit = hit+1 " + "WHERE wrno=#{wrno}")
	public void hitIncrement(int wrno);

	// �긽�꽭蹂닿린
	public ReplyBoardVO replyDetailData(int wrno);

	// �떟蹂� �긽�꽭蹂닿린
	public ReplyBoardVO replyAnswerDetailData(int group_id);

	// �궘�젣
	@Delete("DELETE FROM wine_replyboard WHERE group_id=#{group_id}")
	public void replyDelete(int group_id);

	// �떟蹂� �궘�젣
	@Delete("DELETE FROM wine_replyboard WHERE wrno=#{wrno}")
	public void replyAnswerDelete(int wrno);

	@Update("UPDATE wine_replyboard SET isreply=0 WHERE group_id=(SELECT group_id FROM wine_replyboard WHERE wrno=#{wrno})")
	public void replyQuestStateUpdate(int wrno);

	// �닔�젙
	@Update("UPDATE wine_replyboard SET subject=#{subject}, content=#{content}, cno=#{cno}, secret=#{secret} "
			+ "WHERE wrno=#{wrno}")
	public void replyUpdateData(ReplyBoardVO vo);

	@Update("UPDATE wine_replyboard SET subject=#{subject}, content=#{content} WHERE wrno=#{wrno}")
	public void sellerReplyUpdate(ReplyBoardVO vo);

}
