package com.sist.dao;

import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.WineMapper;
import com.sist.vo.LikeVO;
import com.sist.vo.WineVO;
import com.sist.vo.Wine_PaymentVO;

import java.util.*;

@Repository
public class WineDAO {
	@Autowired
	private WineMapper mapper;
	
	public List<WineVO> wineListData2(Map map){
		return mapper.wineListData2(map);
	}
	
	public int wineTotalCount(Map map) {
		return mapper.wineTotalCount(map);
	}
	
	public int wineTotalPage() {
		return mapper.wineTotalPage();
	}
	
	public List<WineVO> wineFindList(Map map){
		return mapper.wineFindList(map);
	}
	
	public List<WineVO> wineFindData(String fd){
		return mapper.wineFindData(fd);
	}
	
	public int wineFindCount(String fd) {
		return mapper.wineFindCount(fd);
	}
	
	public List<WineVO> adminWineList(Map map){
		return mapper.adminWineList(map);
	}
	public int adminWinePage() {
		return mapper.adminWinePage();
	}
	
	public List<Wine_PaymentVO> myPaymentList(Map map){
		return mapper.myPaymentList(map);
	}
	
	public int myPaymentTotalPage(Map map){
		return mapper.myPaymentTotalPage(map);
	}
	
	public String getSeller(int wno) {
		return mapper.getSeller(wno);
	}
	
	public void paymentStateUpdate1() {
		mapper.paymentStateUpdate1();
	}
	public void paymentStateUpdate2() {
		mapper.paymentStateUpdate2();
	}
	public void paymentStateUpdate3() {
		mapper.paymentStateUpdate3();
	}
	public List<Wine_PaymentVO> paymentGetAccount(){
		return mapper.paymentGetAccount();
	}
	public void wineStackUpdate(Wine_PaymentVO vo) {
		mapper.wineStackUpdate(vo);
	}
	public void sellerAccUpdate(Wine_PaymentVO vo) {
		mapper.sellerAccUpdate(vo);
	}
	public void paymentReturnReques(int wpno) {
		mapper.paymentReturnReques(wpno);
	}
	public int myLikeTotalPage(Map map) {
		return mapper.myLikeTotalPage(map);
	}
	public List<LikeVO> myLikeList(Map map){
		return mapper.myLikeList(map);
	}
	public void likeDelete(int rno) {
		mapper.likeDelete(rno);
	}
	public Map<String, Integer> sellerHomeSaleInfo(String userid){
		return mapper.sellerHomeSaleInfo(userid);
	}
	public Map<String, Integer> sellerHomeWineInfo(String userid){
		return mapper.sellerHomeWineInfo(userid);
	}
	public void reportWineUpdate(int wno) {
		mapper.reportWineUpdate(wno);
	}

}
