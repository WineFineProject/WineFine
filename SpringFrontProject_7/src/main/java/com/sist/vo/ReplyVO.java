package com.sist.vo;
import java.util.*;

import lombok.Data;
/*
 *  FNO              NUMBER       
	RNO     NOT NULL NUMBER       
	ID               VARCHAR2(20) 
	NAME    NOT NULL VARCHAR2(50) 
	MSG     NOT NULL CLOB         
	REGDATE          DATE    
 */
@Data
public class ReplyVO {
  private int rno,fno;
  private String id,name,msg,dbday;
  private Date regdate;
}
