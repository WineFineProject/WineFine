package com.sist.vo;

import java.util.List;

import lombok.Data;
@Data
public class FilterVO {
	private List<String> type;
  private String price;
  private List<String> aroma;
  private List<String> food;
  private int sugarStars;
  private int acidStars;
  private int bodyStars;
  private int tanninStars;
}
