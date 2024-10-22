package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class WineReturnVO {
	private int reno, wpno;
	private String sendid, recvid, content, subject, dbday;
	private Date regdate;
}
