package com.sist.vo;
/*
    wpno NUMBER,         -- 결제 번호 (PRIMARY KEY 추가 고려 가능)
    wno NUMBER,          -- 와인 번호
    account NUMBER,      -- 결제 계정
    payment NUMBER,      -- 결제 금액
    mipoint NUMBER,      -- 사용 포인트
    wdno NUMBER,         -- 배송지 번호
    mcno NUMBER,         -- 쿠폰 번호
    psno NUMBER,         -- 프로모션 번호
    state NUMBER,        -- 상태 (예: 결제 상태)
    userid VARCHAR2(100),-- 사용자 ID
    regdate DATE DEFAULT SYSDATE -- 등록일
 */

import java.util.*;

import lombok.Data;

@Data
public class Wine_PaymentVO {
	private int wpno, wno, account, payment, mipoint, wdno, mcno, psno, state;
	private String userid, dbday;
	private Date regdate;
	private WineVO wvo=new WineVO();
	private MemberVO mvo=new MemberVO();
	private MyCouponVO mcvo=new MyCouponVO();
	private DeliveryVO dvo=new DeliveryVO();
	private PromotionSaleVO svo=new PromotionSaleVO();
}
