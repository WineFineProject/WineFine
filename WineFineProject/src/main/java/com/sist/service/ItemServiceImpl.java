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

}
