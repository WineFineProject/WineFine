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

	
//	와인 리스트 출력
	public List<WineVO> wineListData(int start,int end){
		return mapper.wineListData(start, end);
	}
//	와인 총 페이지
	public int shopTotalPage() {
		return mapper.shopTotalPage();
	}


	
}







