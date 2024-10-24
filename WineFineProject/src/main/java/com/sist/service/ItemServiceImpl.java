package com.sist.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.AccInfoVO;
import com.sist.vo.AccVO;
import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;
import com.sist.vo.MakerVO;
import com.sist.vo.MemberVO;
import com.sist.vo.NoticeBoardVO;
import com.sist.vo.WineReturnVO;
import com.sist.vo.WineVO;
import com.sist.vo.Wine_PaymentVO;
import com.sist.dao.*;

@Service
public class ItemServiceImpl implements ItemService{

	@Autowired
		private ItemDAO dao;
	
	@Override
	public void wineItemInsert(WineVO vo) {
		// TODO Auto-generated method stub
		dao.wineItemInsert(vo);
	}

	@Override
	public List<MakerVO> makerFindListData(String find) {
		// TODO Auto-generated method stub
		return dao.makerFindListData(find);
	}

	@Override
	public List<GrapeVO> grapeFindListData(String find) {
		// TODO Auto-generated method stub
		return dao.grapeFindListData(find);
	}

	@Override
	public List<ItemNationVO> nation1FindListData() {
		// TODO Auto-generated method stub
		return dao.nation1FindListData();
	}

	@Override
	public List<ItemNationVO> nation2FindListData(int areanum) {
		// TODO Auto-generated method stub
		return dao.nation2FindListData(areanum);
	}

	@Override
	public List<ItemNationVO> nation3FindListData(int areanum) {
		// TODO Auto-generated method stub
		return dao.nation3FindListData(areanum);
	}

	@Override
	public List<ItemNationVO> nation4FindListData(int areanum) {
		// TODO Auto-generated method stub
		return dao.nation4FindListData(areanum);
	}

	@Override
	public List<WineVO> sellerItemListData(String seller, int start, int end, String sortOrder) {
		// TODO Auto-generated method stub
		return dao.sellerItemListData(seller, start, end, sortOrder);
	}

	@Override
	public int sellerItemCount(String seller) {
		// TODO Auto-generated method stub
		return dao.sellerItemCount(seller);
	}

	@Override
	public void itemDelete(int wno) {
		// TODO Auto-generated method stub
		dao.itemDelete(wno);
	}

	@Override
	public void deleteItems(List<Integer> wnos) {
		// TODO Auto-generated method stub
		dao.deleteItems(wnos);
	}

	@Override
	public void updateItem(WineVO vo) {
		// TODO Auto-generated method stub
		dao.updateItem(vo);
	}

	@Override
	public WineVO wineItemData(int wno) {
		// TODO Auto-generated method stub
		return dao.wineItemData(wno);
	}

	@Override
	public String getMakerkor(int maker) {
		// TODO Auto-generated method stub
		return dao.getMakerkor(maker);
	}

	@Override
	public List<String> getGrapeNames(List<String> grapeNumbers) {
		// TODO Auto-generated method stub
		return dao.getGrapeNames(grapeNumbers);
	}

	@Override
	public void wineItemUpdate(WineVO vo) {
		// TODO Auto-generated method stub
		dao.wineItemUpdate(vo);
	}

	@Override
	public MemberVO sellerInfoData(String id) {
		// TODO Auto-generated method stub
		return dao.sellerInfoData(id);
	}

	@Override
	public List<NoticeBoardVO> sellerNoticeList(String id) {
		// TODO Auto-generated method stub
		return dao.sellerNoticeList(id);
	}

	@Override
	public List<WineVO> sellerWineList(String id, int end) {
		// TODO Auto-generated method stub
		return dao.sellerWineList(id, end);
	}

	@Override
	public String noticeWineName(int target) {
		// TODO Auto-generated method stub
		return dao.noticeWineName(target);
	}

	@Override
	public List<WineVO> approvalCheckList(String id, int state) {
		// TODO Auto-generated method stub
		return dao.approvalCheckList(id, state);
	}

	@Override
	public int approvalCheckCount(String id, int state) {
		// TODO Auto-generated method stub
		return dao.approvalCheckCount(id, state);
	}

	@Override
	public List<Wine_PaymentVO> orderList(Map map) {
		// TODO Auto-generated method stub
		return dao.orderList(map);
	}

	@Override
	public Map<String, BigDecimal> getOrderCounts(String userId) {
		// TODO Auto-generated method stub
		return dao.getOrderCounts(userId);
	}

	@Override
	public void ordercancelUpdate(int wpno) {
		// TODO Auto-generated method stub
		dao.ordercancelUpdate(wpno);
	}

	@Override
	public WineReturnVO returnCheck(int wpno) {
		// TODO Auto-generated method stub
		return dao.returnCheck(wpno);
	}
	
	@Override
	public void ordereturnUpdate(int wpno) {
		// TODO Auto-generated method stub
		dao.ordereturnUpdate(wpno);
	}

	@Override
	public List<Wine_PaymentVO> accAbleList(int acno) {
		// TODO Auto-generated method stub
		return dao.accAbleList(acno);
	}

	@Override
	public MemberVO mgrade(String userid) {
		// TODO Auto-generated method stub
		return dao.mgrade(userid);
	}

	@Override
	public void accInfoInsert(AccInfoVO vo) {
		// TODO Auto-generated method stub
		dao.accInfoInsert(vo);
	}

	@Override
	public void accInsert(AccVO vo) {
		// TODO Auto-generated method stub
		dao.accInsert(vo);
	}

	@Override
	public void payAcnoUpdate() {
		// TODO Auto-generated method stub
		dao.payAcnoUpdate();
	}

	@Override
	public List<AccVO> sellerAccList(String userid) {
		// TODO Auto-generated method stub
		return dao.sellerAccList(userid);
	}

	@Override
	public AccInfoVO sellerAccInfo(String userid) {
		// TODO Auto-generated method stub
		return dao.sellerAccInfo(userid);
	}

	@Override
	public void pointupdate(String userid) {
		// TODO Auto-generated method stub
		  dao.pointupdate(userid);
	}

	@Override
	public void accInfoUpdate(int grade, String holder, String accountnum, int feerate, String userid) {
		// TODO Auto-generated method stub
		dao.accInfoUpdate(grade, holder, accountnum, feerate, userid);
	}

	

}
