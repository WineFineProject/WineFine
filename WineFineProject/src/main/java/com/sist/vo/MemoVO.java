package com.sist.vo;

import lombok.Data;

@Data
public class MemoVO {
  private int meno;
  private String userid,subject,content,startday,endday,bcolor,fcolor;
}
