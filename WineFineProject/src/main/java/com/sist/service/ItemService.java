package com.sist.service;

import java.util.List;

import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;
import com.sist.vo.MakerVO;
import com.sist.vo.WineVO;

public interface ItemService {
	public void wineItemInsert(WineVO vo);
	public List<MakerVO> makerFindListData(String find);
	public List<GrapeVO> grapeFindListData(String find);
	public List<ItemNationVO> nation1FindListData();
	public List<ItemNationVO> nation2FindListData(int areanum);
	public List<ItemNationVO> nation3FindListData(int areanum);
	public List<ItemNationVO> nation4FindListData(int areanum);
	public List<WineVO> sellerItemListData(String seller, int start, int end);
	public int sellerItemCount(String seller);
	public void itemDelete(int wno);
	public void deleteItems(List<Integer> wnos);
	public void updateItem(WineVO vo);
	public WineVO wineItemData(int wno);
	public String getMakerkor(int maker);
	List<String> getGrapeNames(String grapeNumbers);
	List<String> getNationNames(String nationNumbers);
}
