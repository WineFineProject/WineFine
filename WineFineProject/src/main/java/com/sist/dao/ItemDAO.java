package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.ItemMapper;
import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;
import com.sist.vo.MakerVO;
import com.sist.vo.WineVO;

@Repository
public class ItemDAO {
	@Autowired
		private ItemMapper mapper;
	
	public void wineItemInsert(WineVO vo)
	{
		mapper.wineItemInsert(vo);
	}
	public List<MakerVO> makerFindListData(String find)
	{
		return mapper.makerFindListData(find);
	}
	public List<GrapeVO> grapeFindListData(String find)
	{
		return mapper.grapeFindListData(find);
	}
	public List<ItemNationVO> nation1FindListData()
	{
		return mapper.nation1FindListData();
	}
	public List<ItemNationVO> nation2FindListData(int areanum)
	{
		return mapper.nation2FindListData(areanum);
	}
	public List<ItemNationVO> nation3FindListData(int areanum)
	{
		return mapper.nation3FindListData(areanum);
	}
	public List<ItemNationVO> nation4FindListData(int areanum)
	{
		return mapper.nation4FindListData(areanum);
	}
	
}
