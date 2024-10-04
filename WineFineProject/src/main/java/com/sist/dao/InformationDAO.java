package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.InformationMapper;
import com.sist.vo.*;
import java.util.*;
@Repository
public class InformationDAO {
	@Autowired
    private InformationMapper mapper;

	// 포도 품종 목록 
	public List<GrapeVO> grapeListData() 
	{
        return mapper.grapeListData();
    }

    // 포도 품종 상세 
	public GrapeVO grapeDetailData(int no) 
	{
        return mapper.grapeDetailData(no);
    }
	
	 // 생산지역 목록 
    public List<NationVO> nationListData() 
    {
        return mapper.nationListData();
    }

    // 생산지역 상세 
    public NationVO nationDetailData(int no) 
    {
        return mapper.nationDetailData(no);
    }
    
    // 생산자 목록 
    public List<MakerVO> makerListData() 
    {
        return mapper.makerListData();
    }

    // 생산자 상세 
    public MakerVO makerDetailData(int no) 
    {
        return mapper.makerDetailData(no);
    }
}
