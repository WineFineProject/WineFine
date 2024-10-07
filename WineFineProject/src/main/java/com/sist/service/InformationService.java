package com.sist.service;
import com.sist.vo.*;
import java.util.*;
public interface InformationService {
	public List<GrapeVO> grapeListData(int start, int end); 
	public int grapeTotalPage();
	public GrapeVO grapeDetailData(int no); 
	public List<NationVO> nationListData();
    public NationVO nationDetailData(int no);
    public List<MakerVO> makerListData(); 
    public MakerVO makerDetailData(int no); 
    public List<GrapeVO> findGrapes(String fd);
}
