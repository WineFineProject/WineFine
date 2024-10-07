package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
public interface InformationMapper {
	// 포도 품종 목록 
    @Select("SELECT no, namekor, nameeng, content, num "
    		+"FROM (SELECT no, namekor, nameeng, content, rownum as num "
    		+"FROM (SELECT no, namekor, nameeng, content "
    		+"FROM grape ORDER BY no ASC)) "
    		+"WHERE num BETWEEN #{start} AND #{end}")
    public List<GrapeVO> grapeListData(@Param("start") int start,@Param("end") int end);
    // 포도 품종 총페이지
    @Select("SELECT CEIL(COUNT(*)/12.0) FROM grape")
	public int grapeTotalPage();
    
    // 포도 품종 상세 
    @Select("SELECT no, sugar, acid, body, tannin, namekor, nameeng, aroma, food, nation, content FROM grape WHERE no=#{no}")
    public GrapeVO grapeDetailData(int no);
    
    // 포도 품종 검색
    @Select("SELECT no, namekor, nameeng, content FROM grape "
            +"WHERE namekor LIKE '%'||#{fd}||'%' "
            +"OR nameeng LIKE '%'||#{fd}||'%' "
            +"ORDER BY no")
    public List<GrapeVO> findGrapes(String fd);
    
    // 생산지역 목록 
    @Select("SELECT no, namekor, nameeng, nation, content FROM nation ORDER BY no")
    List<NationVO> nationListData();

    // 생산지역 상세 
    @Select("SELECT no, namekor, nameeng, nation, grape, content FROM nation WHERE no=#{no}")
    NationVO nationDetailData(int no); 
    
    // 생산자 목록 
    @Select("SELECT no, namekor, nameeng, nation, content FROM maker ORDER BY no")
    List<MakerVO> makerListData();

    // 생산자 상세 
    @Select("SELECT no, namekor, nameeng, nation, content FROM maker WHERE no=#{no}")
    MakerVO makerDetailData(int no);
}
