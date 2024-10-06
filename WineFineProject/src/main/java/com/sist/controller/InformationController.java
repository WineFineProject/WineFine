package com.sist.controller;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.InformationService;
import com.sist.vo.*;
@Controller
public class InformationController {
  @Autowired
  private InformationService iService;

  // 포도 목록 페이지
  @GetMapping("grape/list.do")
  public String grapeListData(Model model) 
  {
      List<GrapeVO> grapes=iService.grapeListData();
      model.addAttribute("grapes", grapes);
      return "grape/list"; 
  }

  // 포도 상세 페이지
  @GetMapping("grape/detail.do")
  public String grapeDetailData(int no, Model model) 
  {
      model.addAttribute("no", no);
      return "grape/detail";
  }
  
  // 생산지역 목록 페이지
  @GetMapping("nation/list.do")
  public String nationListData(Model model) 
  {
      List<NationVO> nations=iService.nationListData();
      model.addAttribute("nations", nations);
      return "nation/list";
  }

  // 생산지역 상세 페이지
  @GetMapping("nation/detail.do")
  public String nationDetailData(int no, Model model) 
  {
      model.addAttribute("no", no);
      return "nation/detail"; 
  }
  
  // 생산자 목록 
  @GetMapping("maker/list.do")
  public String makerListData(Model model) 
  {
      List<MakerVO> makers=iService.makerListData();
      model.addAttribute("makers", makers);
      return "maker/list"; 
  }

  // 생산자 상세 
  @GetMapping("maker/detail.do")
  public String makerDetailData(int no, Model model) 
  {
      model.addAttribute("no", no);
      return "maker/detail"; 
  }
}
