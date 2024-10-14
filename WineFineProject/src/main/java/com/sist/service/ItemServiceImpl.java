package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;
import com.sist.vo.MakerVO;
import com.sist.vo.WineVO;
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
	public List<WineVO> sellerItemListData(String seller, int start, int end) {
		// TODO Auto-generated method stub
		return dao.sellerItemListData(seller, start, end);
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
	public List<String> getGrapeNames(String grapeNumbers) {
		// TODO Auto-generated method stub
		return dao.getGrapeNames(grapeNumbers);
	}

	@Override
	public List<String> getNationNames(String nationNumbers) {
		// TODO Auto-generated method stub
		return dao.getNationNames(nationNumbers);
	}

}
