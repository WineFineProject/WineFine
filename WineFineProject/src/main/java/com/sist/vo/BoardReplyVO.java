package com.sist.vo;
import java.util.*;

import lombok.Data;
/*
BRNO	NUMBER
BNO	NUMBER
ID	VARCHAR2(50 BYTE)
CONTENT	CLOB
REGDATE	DATE
ROOT	NUMBER
DEPTH	NUMBER
NICKNAME	VARCHAR2(200 BYTE)
 */
@Data
public class BoardReplyVO {
	private int brno, bno, root, depth;
	private String id, msg, nickname, dbday;
	private Date regdate;
}
