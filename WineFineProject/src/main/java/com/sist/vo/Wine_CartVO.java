package com.sist.vo;
/*
WNO		와인번호
USERID	아이디
REGDATE	장바구니 담은 날
CNO		카트 번호
ACCOUNT	수량
 */
import java.util.*;

import lombok.Data;
@Data
public class Wine_CartVO {
	private int wno,cno,account;
	private String userid,dbdate;
	private Date regdate;
}
