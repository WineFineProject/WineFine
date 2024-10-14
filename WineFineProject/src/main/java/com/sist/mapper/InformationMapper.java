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
    @Select("SELECT wno, namekor, nameeng, type, (SELECT namekor FROM maker WHERE no = wine.maker) AS maker, poster,"
    		+ "(SELECT LISTAGG(namekor, ', ') WITHIN GROUP (ORDER BY namekor DESC) "
    		+ "FROM grape "
    		+ "WHERE (SELECT grape FROM wine w WHERE w.wno = wine.wno) LIKE '%'||#{no}||'%') AS grape,"
    		+ "(SELECT LISTAGG(namekor, ', ') WITHIN GROUP (ORDER BY no ASC) "
    		+ "FROM nation "
    		+ "WHERE (SELECT nation FROM wine w WHERE w.wno = wine.wno) LIKE '%'||#{no}||'%') AS nation "
    		+ "FROM wine "
    		+ "WHERE grape LIKE '%'||#{no}||'%'")
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
    @Select("SELECT wno, namekor, nameeng, type, (SELECT namekor FROM maker WHERE no = wine.maker) AS maker, poster,"
    		+ "(SELECT LISTAGG(namekor, ', ') WITHIN GROUP (ORDER BY namekor DESC) "
    		+ "FROM grape "
    		+ "WHERE (SELECT grape FROM wine w WHERE w.wno = wine.wno) LIKE '%'||#{no}||'%') AS grape,"
    		+ "(SELECT LISTAGG(namekor, ', ') WITHIN GROUP (ORDER BY no ASC) "
    		+ "FROM nation "
    		+ "WHERE (SELECT nation FROM wine w WHERE w.wno = wine.wno) LIKE '%'||#{no}||'%') AS nation "
    		+ "FROM wine "
    		+ "WHERE nation LIKE '%'||#{wno}||'%'")
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
    @Select("SELECT wno, namekor, nameeng, type, (SELECT namekor FROM maker WHERE no = wine.maker) AS maker, poster,"
    		+ "(SELECT LISTAGG(namekor, ', ') WITHIN GROUP (ORDER BY namekor DESC) "
    		+ "FROM grape "
    		+ "WHERE (SELECT grape FROM wine w WHERE w.wno = wine.wno) LIKE '%'||#{no}||'%') AS grape,"
    		+ "(SELECT LISTAGG(namekor, ', ') WITHIN GROUP (ORDER BY no ASC) "
    		+ "FROM nation "
    		+ "WHERE (SELECT nation FROM wine w WHERE w.wno = wine.wno) LIKE '%'||#{no}||'%') AS nation "
    		+ "FROM wine "
    		+ "WHERE maker LIKE '%'||#{wno}||'%'")
    public List<WineVO> makerRelatedWines(Map map);
}
