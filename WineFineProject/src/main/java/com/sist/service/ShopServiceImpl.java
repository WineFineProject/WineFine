package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.ShopDAO;
import com.sist.dao.WineDAO;
import com.sist.vo.MyCouponVO;
import com.sist.vo.PromotionSaleVO;
import com.sist.vo.WineVO;

@Service
public class ShopServiceImpl implements ShopService{
	private ShopDAO sdao;
	private WineDAO wDao;
	@Autowired
	public ShopServiceImpl(ShopDAO sdao, WineDAO wDao) {
		this.sdao = sdao;
		this.wDao = wDao;
	}
	
	@Override
	public List<WineVO> wineListData(int start, int end) {
		// TODO Auto-generated method stub
		return sdao.wineListData(start, end);
	}

	@Override
	public int shopTotalPage() {
		// TODO Auto-generated method stub
		return sdao.shopTotalPage();
	}

	@Override
	public List<WineVO> wineFindList(Map map) {
		return wDao.wineFindList(map);
	}
	
	@Override
	public WineVO wineDetailData(int wno) {		
		return sdao.wineDetailData(wno);
	}
	@Override
	public List<String> grapeName(int wno) {
		// TODO Auto-generated method stub
		return sdao.grapeName(wno);
	}
	@Override
	public List<String> nationName(int wno) {
		// TODO Auto-generated method stub
		return sdao.nationName(wno);
	}
	@Override
	public WineVO winebuy(int wno) {
		// TODO Auto-generated method stub
		return sdao.winebuy(wno);
	}
	@Override
	public List<MyCouponVO> selectCoupon(String id) {
		// TODO Auto-generated method stub
		return sdao.selectCoupon(id);
	}
	@Override
	public MyCouponVO useCoupon(String id) {
		// TODO Auto-generated method stub
		return sdao.useCoupon(id);
	}
	@Override
	public PromotionSaleVO promotionGetSale(Map map) {
		// TODO Auto-generated method stub
		return sdao.promotionGetSale(map);
	}

}
