package com.sist.vo;
import java.util.*;

import lombok.Data;
@Data
public class ReplyBoardVO {
   private int wrno,cno,type,wno,group_id,group_step,isreply,hit,secret;
   private String userid,nickname,subject,content,recvid,dbday;
   private Date regdate;
   private WineVO wvo=new WineVO();
}
