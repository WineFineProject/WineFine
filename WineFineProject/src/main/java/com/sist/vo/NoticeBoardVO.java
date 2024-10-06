package com.sist.vo;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class NoticeBoardVO {
	private int nbno, type, target, hit, isNotice;
	private String userid, nickname, subject, content, dbday, targetName;
	private Date regdate;
}
