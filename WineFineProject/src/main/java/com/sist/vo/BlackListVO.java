package com.sist.vo;

import java.util.*;

import lombok.Data;

@Data
public class BlackListVO {
  private int blno;
  private String recvid, sendid, content, dbday;
  private Date regdate;
}
