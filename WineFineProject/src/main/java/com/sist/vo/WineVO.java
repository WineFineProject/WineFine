package com.sist.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class WineVO {
    private int wno, sugar, acid, body, tannin, stack, score, hit, likecount, state, nbno;
    private String namekor, nameeng, type, price, vol, aroma, food, maker, makerkor, makereng,
    			   alcohol, seller, poster, grape, nation, dbday;
    private Date regdate;
    private MemberVO mvo = new MemberVO();
    private MakerVO mmvo = new MakerVO();
    
}
