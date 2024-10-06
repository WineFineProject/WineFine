package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.*;
import java.util.*;
@Repository
public class NoticeBoardDAO {
	@Autowired
	private NoticeBoardMapper mapper;
	
	public void noticeBoardInsert(NoticeBoardVO vo) {
		mapper.noticeBoardPopupUpdate(vo);
		mapper.noticeBoardInsert(vo);
	}
}