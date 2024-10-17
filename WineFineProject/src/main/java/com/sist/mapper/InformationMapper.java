package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
public interface InformationMapper {

	// 포도 품종 목록, 검색
    @Select("SELECT no, namekor, nameeng, content, num "
    		+"FROM (SELECT no, namekor, nameeng, content, rownum as num "
    		+"FROM (SELECT no, namekor, nameeng, content "
    		+"FROM grape "
            +"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%' "
            +"ORDER BY no)) "
            +"WHERE num BETWEEN #{start} AND #{end}")
    public List<GrapeVO> grapeListData(Map map);
    // 포도 품종 총페이지
    @Select("SELECT COUNT(*) FROM grape "
    		+"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%'")
    public int grapeTotalPage(Map map);
    
	// 포도 품종 상세 
    @Select("SELECT no, sugar, acid, body, tannin, namekor, nameeng, aroma, food, nation, content FROM grape WHERE no=#{no}")
    public GrapeVO grapeDetailData(int no);
    
    // 포도 품종 관련 와인
    @Select("SELECT w.wno, w.namekor, w.nameeng, w.type, w.poster, (SELECT m.namekor FROM maker m WHERE m.no = w.maker) AS maker, "
    		+ "(SELECT LISTAGG(g.namekor, ', ') WITHIN GROUP (ORDER BY g.namekor DESC) "
    		+ "FROM (SELECT REGEXP_SUBSTR(w.grape, '[^,]+', 1, LEVEL) AS grape_no "
    		+ "FROM dual CONNECT BY REGEXP_SUBSTR(w.grape, '[^,]+', 1, LEVEL) IS NOT NULL) t JOIN grape g ON t.grape_no = g.no) AS grape, "
    		+ "(SELECT LISTAGG(n.namekor, ', ') WITHIN GROUP (ORDER BY n.namekor DESC) "
    		+ "FROM (SELECT REGEXP_SUBSTR(w.nation, '[^,]+', 1, LEVEL) AS nation_no "
    		+ "FROM dual CONNECT BY REGEXP_SUBSTR(w.nation, '[^,]+', 1, LEVEL) IS NOT NULL) t JOIN nation n ON t.nation_no = n.no) AS nation "
    		+ "FROM wine w "
    		+ "WHERE EXISTS ( "
    		+ "SELECT 1 FROM (SELECT REGEXP_SUBSTR(w.grape, '[^,]+', 1, LEVEL) AS grape_no "
    		+ "FROM dual CONNECT BY REGEXP_SUBSTR(w.grape, '[^,]+', 1, LEVEL) IS NOT NULL) t "
    		+ "WHERE t.grape_no = #{no})")
    public List<WineVO> grapeRelatedWines(Map map);
    
    // 생산지역 목록, 검색 
    @Select("SELECT no, namekor, nameeng, nation, content , num "
    		+"FROM (SELECT no, namekor, nameeng, nation, content , rownum as num "
    		+"FROM (SELECT no, namekor, nameeng, nation, content "
    		+"FROM nation "
    		+"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%' "
    		+"ORDER BY no ASC)) "
    		+"WHERE num BETWEEN #{start} AND #{end}")
    public List<NationVO> nationListData(Map map);
    // 생산지역 총페이지
    @Select("SELECT COUNT(*) FROM nation "
    		+"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%'")
	public int nationTotalPage(Map map);
    
    // 생산지역 상세 
    @Select("SELECT no, namekor, nameeng, nation, grape, content FROM nation WHERE no=#{no}")
    public NationVO nationDetailData(int no); 
    
    // 생산지역 관련 와인
    @Select("SELECT w.wno, w.namekor, w.nameeng, w.type, w.poster, (SELECT m.namekor FROM maker m WHERE m.no = w.maker) AS maker, "
    		+ "(SELECT LISTAGG(g.namekor, ', ') WITHIN GROUP (ORDER BY g.namekor DESC) "
    		+ "FROM (SELECT REGEXP_SUBSTR(w.grape, '[^,]+', 1, LEVEL) AS grape_no "
    		+ "FROM dual CONNECT BY REGEXP_SUBSTR(w.grape, '[^,]+', 1, LEVEL) IS NOT NULL) t JOIN grape g ON t.grape_no = g.no) AS grape, "
    		+ "(SELECT LISTAGG(n.namekor, ', ') WITHIN GROUP (ORDER BY n.namekor DESC) "
    		+ "FROM (SELECT REGEXP_SUBSTR(w.nation, '[^,]+', 1, LEVEL) AS nation_no "
    		+ "FROM dual CONNECT BY REGEXP_SUBSTR(w.nation, '[^,]+', 1, LEVEL) IS NOT NULL) t JOIN nation n ON t.nation_no = n.no) AS nation "
    		+ "FROM wine w "
    		+ "WHERE EXISTS ( "
    		+ "SELECT 1 FROM (SELECT REGEXP_SUBSTR(w.nation, '[^,]+', 1, LEVEL) AS nation_no "
    		+ "FROM dual CONNECT BY REGEXP_SUBSTR(w.nation, '[^,]+', 1, LEVEL) IS NOT NULL) t "
    		+ "WHERE t.nation_no = #{no})")
    public List<WineVO> nationRelatedWines(Map map);
    
    // 생산자 목록 
    @Select("SELECT no, namekor, nameeng, nation, content, num "
    		+"FROM (SELECT no, namekor, nameeng, nation, content, rownum as num "
    		+"FROM (SELECT no, namekor, nameeng, nation, content "
    		+"FROM maker "
    		+"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%' "
    		+"ORDER BY no ASC)) "
    		+"WHERE num BETWEEN #{start} AND #{end}")
    public List<MakerVO> makerListData(Map map);
    // 생산자 총페이지
    @Select("SELECT COUNT(*) FROM maker "
    		+"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%'")
	public int makerTotalPage(Map map);
    
    // 생산자 상세 
    @Select("SELECT no, namekor, nameeng, nation, content FROM maker WHERE no=#{no}")
    public MakerVO makerDetailData(int no);
    
    // 생산자 관련 와인
    @Select("SELECT w.wno, w.namekor, w.nameeng, w.type, w.nation, w.grape, w.poster, m.namekor AS maker "
            + "FROM wine w "
            + "JOIN maker m ON w.maker = m.no "
            + "WHERE m.no = #{no}")
    public List<WineVO> makerRelatedWines(Map map);
    
    @Select("SELECT * FROM grape WHERE namekor LIKE '%'||#{fd}||'%' AND rownum<=4")
    public List<GrapeVO> grapeFindData(String fd);
    
    @Select("SELECT COUNT(*) FROM grape WHERE namekor LIKE '%'||#{fd}||'%'")
    public int grapeFindCount(String fd);
    
    @Select("SELECT * FROM nation WHERE namekor LIKE '%'||#{fd}||'%' AND rownum<=4")
    public List<NationVO> nationFindData(String fd);
 
    @Select("SELECT COUNT(*) FROM nation WHERE namekor LIKE '%'||#{fd}||'%'")
    public int nationFindCount(String fd);
    
    @Select("SELECT * FROM maker WHERE namekor LIKE '%'||#{fd}||'%' AND rownum<=4")
    public List<MakerVO> makerFindData(String fd);
    
    @Select("SELECT COUNT(*) FROM maker WHERE namekor LIKE '%'||#{fd}||'%'")
    public int makerFindCount(String fd);
}
