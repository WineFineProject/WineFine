package com.sist.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.InformationMapper;
import com.sist.vo.*;
import java.util.*;

@Repository
public class InformationDAO {
	@Autowired
	private InformationMapper mapper;

	// 포도 품종 목록, 검색
	public List<GrapeVO> grapeListData(Map map) {
		return mapper.grapeListData(map);
	}

	// 포도 품종 총페이지
	public int grapeTotalPage(Map map) {
		return mapper.grapeTotalPage(map);
	}

	// 포도 품종 상세
	public GrapeVO grapeDetailData(int no) {
		return mapper.grapeDetailData(no);
	}

	// 포도 품종 관련 와인
	public List<WineVO> grapeRelatedWines(Map map) {
		return mapper.grapeRelatedWines(map);
	}

	// 생산지역 목록, 검색
	public List<NationVO> nationListData(Map map) {
		return mapper.nationListData(map);
	}

	// 생산지역 총페이지
	public int nationTotalPage(Map map) {
		return mapper.nationTotalPage(map);
	}

	// 생산지역 상세
	public NationVO nationDetailData(int no) {
		return mapper.nationDetailData(no);
	}

	// 생산지역 관련 와인
	public List<WineVO> nationRelatedWines(Map map) {
		return mapper.nationRelatedWines(map);
	}

	// 생산자 목록, 검색
	public List<MakerVO> makerListData(Map map) {
		return mapper.makerListData(map);
	}

	// 생산자 총페이지
	public int makerTotalPage(Map map) {
		return mapper.makerTotalPage(map);
	}

	// 생산자 상세
	public MakerVO makerDetailData(int no) {
		return mapper.makerDetailData(no);
	}

	// 생산자 관련 와인
	public List<WineVO> makerRelatedWines(Map map) {
		return mapper.makerRelatedWines(map);
	}

	public List<GrapeVO> grapeFindData(String fd){
		return mapper.grapeFindData(fd);
	}
  
  public int grapeFindCount(String fd) {
  	return mapper.grapeFindCount(fd);
  }
  
  public List<NationVO> nationFindData(String fd){
  	return mapper.nationFindData(fd);
  }

  public int nationFindCount(String fd) {
  	return mapper.nationFindCount(fd);
  }
  
  public List<MakerVO> makerFindData(String fd){
  	return mapper.makerFindData(fd);
  }
  
  public int makerFindCount(String fd) {
  	return mapper.makerFindCount(fd);
  }
}
