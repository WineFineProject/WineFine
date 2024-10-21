package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.*;
import com.sist.vo.*;

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
	public List<PromotionSaleVO> promotionGetSale(Map map) {
		// TODO Auto-generated method stub
		return sdao.promotionGetSale(map);
	}
	@Override
	public List<WineVO> otherWine_seller(int wno) {
		// TODO Auto-generated method stub
		return sdao.otherWine_seller(wno);
	}
	@Override
	public List<WineVO> otherWine_maker(int wno) {
		// TODO Auto-generated method stub
		return sdao.otherWine_maker(wno);
	}
	@Override
	public String getPoint(String id) {
		// TODO Auto-generated method stub
		return sdao.getPoint(id);
	}
	@Override
	public List<DeliveryVO> getDeli(String id) {
		// TODO Auto-generated method stub
		return sdao.getDeli(id);
	}
	
	@Override
	public void usePoint(MemberVO vo) {
		// TODO Auto-generated method stub
		sdao.usePoint(vo);
	}

	@Override
	public void plusPoint(MemberVO vo) {
		// TODO Auto-generated method stub
		sdao.plusPoint(vo);
	}

	@Override
	public void useCoupon(MyCouponVO vo) {
		// TODO Auto-generated method stub
		sdao.useCoupon(vo);
	}
	@Override
	public void insertCart(Wine_CartVO vo) {
		// TODO Auto-generated method stub
		sdao.insertCart(vo);
	}
	@Override
	public void wineCartAccountUpdate(Wine_CartVO vo) {
		// TODO Auto-generated method stub
		sdao.wineCartAccountUpdate(vo);
	}
	@Override
	public int wineCartwnoCount(int wno) {
		// TODO Auto-generated method stub
		return sdao.wineCartwnoCount(wno);
	}

	@Override
	public void insertPayment(Wine_PaymentVO vo) {
		// TODO Auto-generated method stub
		sdao.insertPayment(vo);
	}

	@Override
	public void wineBuyAccountUpdate(Wine_PaymentVO vo) {
		// TODO Auto-generated method stub
		sdao.wineBuyAccountUpdate(vo);
	}

	@Override
	public int wineBuywpnoCount(int wpno) {
		// TODO Auto-generated method stub
		return sdao.wineBuywpnoCount(wpno);
	}
	@Override
	public String getgrade(String id) {
		// TODO Auto-generated method stub
		return sdao.getgrade(id);
	}

	@Override
	public List<WineVO> wineFindData(String fd) {
		return wDao.wineFindData(fd);
	}
	
	@Override
	public int wineFindCount(String fd) {
		return wDao.wineFindCount(fd);
	}
	
	@Override
	public void insertReport(Wine_ReportVO vo) {		
		sdao.insertReport(vo);
	}
	
	@Override
	public List<WineVO> adminWineList(Map map) {
		return wDao.adminWineList(map);
	}
	
	@Override
	public int adminWinePage() {
		return wDao.adminWinePage();
	}
	
	@Override
	public List<Wine_PaymentVO> myPaymentList(Map map) {
		return wDao.myPaymentList(map);
	}
	
	@Override
	public int myPaymentTotalPage(Map map) {
		return wDao.myPaymentTotalPage(map);
	}
	
	@Override
	public int wineCount() {
		return sdao.wineCount();
	}
	@Override
	public LikeVO wineLikeOff(LikeVO lvo) {
		// TODO Auto-generated method stub
		return sdao.wineLikeOff(lvo);
	}
	@Override
	public LikeVO wineLikeOn(LikeVO lvo) {
		// TODO Auto-generated method stub
		return sdao.wineLikeOn(lvo);
	}
	@Override
	public String selectUsername(int wno) {
		// TODO Auto-generated method stub
		return sdao.selectUsername(wno);
	}

	
	
}








