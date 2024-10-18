package com.sist.vo;
import java.util.*;

import lombok.Data;
@Data
public class ReserveVO {
  private int rno, weno, person;
  private String dbday, userid;
  private Date regdate;
  private EventVO evo=new EventVO();
}
