package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.ItemMapper;
import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;
import com.sist.vo.MakerVO;
import com.sist.vo.MemberVO;
import com.sist.vo.NoticeBoardVO;
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
	 public List<WineVO> sellerItemListData(String seller, int start, int end, String sortOrder)
	 {
		 return mapper.sellerItemListData(seller, start, end, sortOrder);
	 }
	 public int sellerItemCount(String seller)
	 {
		 return mapper.sellerItemCount(seller);
	 }
	 public void itemDelete(int wno)
	 {
		 mapper.itemDelete(wno);
	 }
	 public void deleteItems(List<Integer> wnos)
	 {
		 mapper.deleteItems(wnos);
	 }
	 public void updateItem(WineVO vo)
	 {
		 mapper.updateItem(vo);
	 }
	 public WineVO wineItemData(int wno)
	 {
		 return mapper.wineItemData(wno);
	 }
	 public String getMakerkor(int maker)
	 {
		 return mapper.getMakerkor(maker);
	 }
	 public List<String> getGrapeNames(List<String> grapeNumbers)
	 {
		 return mapper.getGrapeNames(grapeNumbers);
	 }
	 public void wineItemUpdate(WineVO vo)
	 {
		 mapper.wineItemUpdate(vo);
	 }
	 public MemberVO sellerInfoData(String id)
	 {
		 return mapper.sellerInfoData(id);
	 }
	 public List<NoticeBoardVO> sellerNoticeList(String id)
	 {
		 return mapper.sellerNoticeList(id);
	 }
	 public List<WineVO> sellerWineList(String id, int end)
	 {
		 return mapper.sellerWineList(id, end);
	 }
	 public String noticeWineName(int target)
	 {
		 return mapper.noticeWineName(target);
	 }
	 public List<WineVO> approvalCheckList(String id, int state)
	 {
		 return mapper.approvalCheckList(id, state);
	 }
	 public int approvalCheckCount(String id, int state)
	 {
		 return mapper.approvalCheckCount(id, state);				 
	 }
}
