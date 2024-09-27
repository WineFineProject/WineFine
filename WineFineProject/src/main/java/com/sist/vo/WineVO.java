package com.sist.vo;
/*
WNO	NUMBER
NAMEKOR	VARCHAR2(2000 BYTE)
NAMEENG	VARCHAR2(2000 BYTE)
TYPE	VARCHAR2(2000 BYTE)
PRICE	VARCHAR2(2000 BYTE)
VOL	VARCHAR2(2000 BYTE)
SUGAR	NUMBER
ACID	NUMBER
BODY	NUMBER
TANNIN	NUMBER
AROMA	VARCHAR2(2000 BYTE)
FOOD	VARCHAR2(2000 BYTE)
MAKER	VARCHAR2(2000 BYTE)
NATION	VARCHAR2(2000 BYTE)
GRAPE	VARCHAR2(2000 BYTE)
ALCOHOL	VARCHAR2(2000 BYTE)
SELLER	VARCHAR2(2000 BYTE)
STACK	NUMBER
SCORE	NUMBER
HIT	NUMBER
REGDATE	DATE
LIKECOUNT	NUMBER
POSTER	VARCHAR2(3000 BYTE)
 */

import java.util.Date;

import lombok.Data;
@Data
public class WineVO {
	private int wno, sugar, acid, body, tannin, stack, score, hit, likecount;
	private String namekor, nameeng, type, price, vol, aroma, food, maker, nation, grape, alcohol, seller, poster, dbday;
	private Date regdate;
}
