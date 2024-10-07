package com.sist.service;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.*;
import com.sist.dao.*;
@Service
public class BlackListServiceImpl implements BlackListService{
	@Autowired
    private BlackListDAO bDao;

	@Override
	public List<BlackListVO> blackListData(int start, int end) {
		// TODO Auto-generated method stub
		return bDao.blackListData(start, end);
	}

	@Override
	public void blackListInsert(BlackListVO vo) {
		// TODO Auto-generated method stub
		bDao.blackListInsert(vo);
	}
}
