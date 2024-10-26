package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
public interface ReportMapper {
  public List<Wine_ReportVO> reportListData(Map map);
  
  @Select("SELECT COUNT(*) FROM wine_report")
  public int reportListCount();
  
  @Update("UPDATE wine_report SET state=1 WHERE wreno=#{wreno}")
  public void reportState(int wreno);
  
  @Results({
	  @Result(property = "bvo.bno",column = "bno"),
	  @Result(property = "bvo.id",column = "id"),
	  @Result(property = "bvo.nickname",column = "nickname"),
	  @Result(property = "bvo.subject",column = "subject"),
	  @Result(property = "bvo.content",column = "content1"),
	  @Result(property = "bvo.dbday",column = "dbdate"),
	  @Result(property = "bvo.cno",column = "cno")
  })
  @Select("SELECT wr.wreno, wr.type, wr.category, wr.content, wr.userid, wr.rid, wr.tno,"
  		+ "TO_CHAR(wr.regdate, 'YYYY-MM-DD') as dbday, wr.state, b.bno, b.id, b.nickname, b.subject,"
		+ "b.content as content1, TO_CHAR(b.regdate, 'YYYY-MM-DD') as dbdate, b.cno "  
  		+ "FROM wine_report wr JOIN board b ON wr.tno=b.bno "
  		+ "WHERE wr.wreno=#{wreno}")
  public Wine_ReportVO reportBoardData(int wreno);

  @Results({
	  @Result(property = "brvo.brno",column = "brno"),
	  @Result(property = "brvo.id",column = "id"),
	  @Result(property = "brvo.msg",column = "msg"),
	  @Result(property = "brvo.dbday",column = "dbdate"),
	  @Result(property = "brvo.nickname",column = "nickname")
  })
  @Select("SELECT wr.wreno, wr.type, wr.category, wr.content, wr.userid, wr.rid, wr.tno,"
	  	  + "TO_CHAR(wr.regdate, 'YYYY-MM-DD') as dbday, wr.state, b.brno, b.id, b.msg,"
		  + "TO_CHAR(b.regdate, 'YYYY-MM-DD') as dbdate, b.nickname "  
	  	  + "FROM wine_report wr JOIN boardreply b ON wr.tno=b.brno "
	  	  + "WHERE wr.wreno=#{wreno}")
  public Wine_ReportVO reportReplyData(int wreno);
  
  @Results({
	  @Result(property = "wvo.wno",column = "wno"),
	  @Result(property = "wvo.namekor",column = "namekor"),
	  @Result(property = "wvo.nameeng",column = "nameeng"),
	  @Result(property = "wvo.type",column = "type1"),
	  @Result(property = "wvo.price",column = "price"),
	  @Result(property = "wvo.vol",column = "vol"),
	  @Result(property = "wvo.sugar",column = "sugar"),
	  @Result(property = "wvo.acid",column = "acid"),
	  @Result(property = "wvo.body",column = "body"),
	  @Result(property = "wvo.tannin",column = "tannin"),
	  @Result(property = "wvo.aroma",column = "aroma"),
	  @Result(property = "wvo.food",column = "food"),
	  @Result(property = "wvo.alcohol",column = "alcohol"),
	  @Result(property = "wvo.seller",column = "seller"),
	  @Result(property = "wvo.score",column = "score"),
	  @Result(property = "wvo.dbday",column = "dbdate"),
	  @Result(property = "wvo.mvo.nickName",column = "nickname"),
	  @Result(property = "wvo.poster",column = "poster"),
	  @Result(property = "wvo.grape",column = "grape"),
	  @Result(property = "wvo.nation",column = "nation"),
	  @Result(property = "wvo.maker",column = "maker")
  })
  @Select("SELECT wr.wreno, wr.type, wr.category, wr.content, wr.userid, wr.rid, wr.tno,"
	  	  + "TO_CHAR(wr.regdate, 'YYYY-MM-DD') as dbday, wr.state, b.wno, b.namekor, b.nameeng,"
		  + "b.type as type1, b.price, b.vol, b.sugar, b.acid, b.body, b.tannin, b.aroma, b.food, b.alcohol,"
	  	  + "b.score, TO_CHAR(b.regdate, 'YYYY-MM-DD') as dbdate, b.poster, m.nickname, "
	  	  + "(SELECT m.namekor FROM maker m WHERE m.no = b.maker) AS maker, "
	  	  + "(SELECT LISTAGG(g.namekor, ', ') WITHIN GROUP (ORDER BY g.namekor DESC) "
	  	  + "FROM (SELECT REGEXP_SUBSTR(b.grape, '[^,]+', 1, LEVEL) AS grape_no "
	  	  + "FROM dual CONNECT BY REGEXP_SUBSTR(b.grape, '[^,]+', 1, LEVEL) IS NOT NULL) t JOIN grape g ON t.grape_no = g.no) AS grape,"
	  	  + "(SELECT LISTAGG(n.namekor, ' | ') WITHIN GROUP (ORDER BY n.namekor DESC) "
	  	  + "FROM (SELECT REGEXP_SUBSTR(b.nation, '[^,]+', 1, LEVEL) AS nation_no "
	  	  + "FROM dual CONNECT BY REGEXP_SUBSTR(b.nation, '[^,]+', 1, LEVEL) IS NOT NULL) t JOIN nation n ON t.nation_no = n.no) AS nation "
	  	  + "FROM wine_report wr JOIN wine b ON wr.tno=b.wno "
	  	  + "JOIN wine_member m ON m.userId=b.seller "
	  	  + "WHERE wr.wreno=#{wreno}")
  public Wine_ReportVO reportWineData(int wreno);
  
  @Results({
	  @Result(property = "wrvo.brno",column = "brno"),
	  @Result(property = "wrvo.wno",column = "wno"),
	  @Result(property = "wrvo.userid",column = "userid1"),
	  @Result(property = "wrvo.nickname",column = "nickname"),
	  @Result(property = "wrvo.dbday",column = "dbdate"),
	  @Result(property = "wrvo.content",column = "content1"),
	  @Result(property = "wrvo.srating",column = "srating")
  })
  @Select("SELECT wr.wreno, wr.type, wr.category, wr.content, wr.userid, wr.rid, wr.tno,"
	  	  + "TO_CHAR(wr.regdate, 'YYYY-MM-DD') as dbday, wr.state, b.wrvno, b.wno, b.userid as userid1,"
		  + "b.nickname, TO_CHAR(b.regdate, 'YYYY-MM-DD') as dbdate, b.content as content1, b.srating "  
	  	  + "FROM wine_report wr JOIN wine_review b ON wr.tno=b.wrvno "
	  	  + "WHERE wr.wreno=#{wreno}")
  public Wine_ReportVO reportReviewData(int wreno);
}
