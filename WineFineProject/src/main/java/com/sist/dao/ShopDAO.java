package com.sist.dao;
import java.util.*;
import com.sist.mapper.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAO {
	private ShopMapper mapper;
	@Autowired
	public ShopDAO(ShopMapper mapper) {
		this.mapper = mapper;
	}
	
	
}
