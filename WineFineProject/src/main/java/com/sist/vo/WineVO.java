package com.sist.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class WineVO {
    private int wno, sugar, acid, body, tannin, stack, score, hit, likecount;
    private String namekor, nameeng, type, price, vol, aroma, food, makerkor, makereng,
    			   alcohol, seller, poster, grape, nation;
    private Date regdate;
    private MemberVO mvo = new MemberVO();
}
