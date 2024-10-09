package com.sist.service;
import com.sist.vo.*;
import java.util.*;
public interface InformationService {
	public List<GrapeVO> grapeListData(Map map); 
	public int grapeTotalPage(Map map);
	public GrapeVO grapeDetailData(int no); 
	public List<WineVO> grapeRelatedWines(Map map);
	public List<NationVO> nationListData(Map map);
	public int nationTotalPage(Map map);
    public NationVO nationDetailData(int no);
    public List<WineVO> nationRelatedWines(Map map);
    public List<MakerVO> makerListData(Map map); 
    public int makerTotalPage(Map map);
    public MakerVO makerDetailData(int no); 
    public List<WineVO> makerRelatedWines(Map map);
}
