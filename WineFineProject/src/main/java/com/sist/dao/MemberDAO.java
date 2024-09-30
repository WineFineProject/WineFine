package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MemberMapper;

@Repository
public class MemberDAO {
	@Autowired
	private MemberMapper mapper;
	
	public String memberLogin(String id, String pwd) {
		String result="NO";
		int count=mapper.memberCountId(id);
		if(count==0)
			result="NOID";
		else {
			String tmp=mapper.memberGetPwd(id);
			if(tmp.equals(pwd)) {
				result="OK";
			}
			else {
				result="NOPWD";
			}
		}
		return result;
	}
}
