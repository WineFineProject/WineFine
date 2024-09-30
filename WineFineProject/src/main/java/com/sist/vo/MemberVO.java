package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data

public class MemberVO {
	private String id, nickname, pwd, name, dbbirthday, dbregdate, sex, phone, post, addr1, addr2, photo, msg, email;
	private int grade, admin;
	private Date birthdate, regdate;
	
	
}
