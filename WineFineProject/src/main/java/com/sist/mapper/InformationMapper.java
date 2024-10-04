package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Select;
public interface InformationMapper {
	// 포도 품종 목록 
    @Select("SELECT namekor, nameeng, content FROM grape ORDER BY no")
    public List<GrapeVO> grapeListData();

    // 포도 품종 상세 
    @Select("SELECT sugar, acid, body, tannin, namekor, nameeng, aroma, food, nation, content FROM grape WHERE no=#{no}")
    public GrapeVO grapeDetailData(int no);
    
    // 생산지역 목록 
    @Select("SELECT namekor, nameeng, nation, content FROM nation ORDER BY no")
    List<NationVO> nationListData();

    // 생산지역 상세 
    @Select("SELECT namekor, nameeng, nation, grape, content FROM nation WHERE no=#{no}")
    NationVO nationDetailData(int no); 
    
    // 생산자 목록 
    @Select("SELECT namekor, nameeng, nation, content FROM maker ORDER BY no")
    List<MakerVO> makerListData();

    // 생산자 상세 
    @Select("SELECT namekor, nameeng, nation, content FROM maker WHERE no=#{no}")
    MakerVO makerDetailData(int no);
}
