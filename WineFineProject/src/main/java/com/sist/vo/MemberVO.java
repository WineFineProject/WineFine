package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String userId, nickName, userPwd, userName, sex, birthday, email, post, addr1, addr2, phone, phone1, phone2, phone3, photo, regday, motifyday,lastloginday, authority;
	private int grade, mipoint, plpoint, point, enabled, state;
	private Date modifydate, regdate, lastlogin;
		
}
