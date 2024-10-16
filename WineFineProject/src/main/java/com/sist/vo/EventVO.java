package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class EventVO {
  private int weno, maxperson;
  private String title,address,poster,posters,eday;
  private Date eventdate;
}
