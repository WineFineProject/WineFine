package com.sist.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;
import com.sist.vo.MakerVO;
import com.sist.vo.MemberVO;
import com.sist.vo.NoticeBoardVO;
import com.sist.vo.WineVO;
import com.sist.vo.Wine_PaymentVO;

public interface ItemService {
	public void wineItemInsert(WineVO vo);
	public List<MakerVO> makerFindListData(String find);
	public List<GrapeVO> grapeFindListData(String find);
	public List<ItemNationVO> nation1FindListData();
	public List<ItemNationVO> nation2FindListData(int areanum);
	public List<ItemNationVO> nation3FindListData(int areanum);
	public List<ItemNationVO> nation4FindListData(int areanum);
	public List<WineVO> sellerItemListData(String seller, int start, int end, String sortOrder);
	public int sellerItemCount(String seller);
	public void itemDelete(int wno);
	public void deleteItems(List<Integer> wnos);
	public void updateItem(WineVO vo);
	public WineVO wineItemData(int wno);
	public String getMakerkor(int maker);
	public List<String> getGrapeNames(List<String> grapeNumbers);
	public void wineItemUpdate(WineVO vo);
	public MemberVO sellerInfoData(String id);
	public List<NoticeBoardVO> sellerNoticeList(String id);
	public List<WineVO> sellerWineList(String id, int end);
	public String noticeWineName(int target);
	public List<WineVO> approvalCheckList(String id, int state);
	public int approvalCheckCount(String id, int state);
	public List<Wine_PaymentVO> orderList(Map map);
	public Map<String, BigDecimal> getOrderCounts(String userId);
	public void ordercancelUpdate(int wpno);
	public void ordereturnUpdate(int wpno);
	 
}
