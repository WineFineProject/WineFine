package com.sist.dao;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.WineVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAO {
	private ShopMapper mapper;
	@Autowired
	public ShopDAO(ShopMapper mapper) {
		this.mapper = mapper;
	}

	
//	���씤 由ъ뒪�듃 異쒕젰
	public List<WineVO> wineListData(int start,int end){
		return mapper.wineListData(start, end);
	}
//	���씤 珥� �럹�씠吏�
	public int shopTotalPage() {
		return mapper.shopTotalPage();
	}
//	상세보기
	public WineVO wineDetailData(int wno) {
	    mapper.hitIncrement(wno);
	    return mapper.wineDetailData(wno);
	}



	
}







