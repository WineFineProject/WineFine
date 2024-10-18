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
	public void blackListInsert(BlackListVO vo) {
		// TODO Auto-generated method stub
		bDao.blackListInsert(vo);
	}

	@Override
	public List<MemberVO> blackList(Map map) {
		// TODO Auto-generated method stub
		return bDao.blackList(map);
	}

	@Override
	public int blackListCount(Map map) {
		// TODO Auto-generated method stub
		return bDao.blackListCount(map);
	}

	@Override
	public void blackListDelete(BlackListVO vo) {
		// TODO Auto-generated method stub
		bDao.blackListDelete(vo);
	}

}
