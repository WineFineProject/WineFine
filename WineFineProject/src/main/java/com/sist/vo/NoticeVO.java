package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private int nno, state;
	private String subject, content, sendid, recvid, dbday;
	private Date regdate;
}
