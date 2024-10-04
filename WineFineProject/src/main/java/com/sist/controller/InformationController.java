package com.sist.controller;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
      List<GrapeVO> grapes = iService.grapeListData();
      model.addAttribute("grapes", grapes);
      return "grape/list"; 
  }

  // 포도 상세 페이지
  @GetMapping("grape/detail.do")
  public String grapeDetailData(@RequestParam("no") int no, Model model) 
  {
      GrapeVO grape = iService.grapeDetailData(no);
      model.addAttribute("grape", grape);
      return "grape/detail";
  }
  
  //생산지역 목록 페이지
  @GetMapping("nation/list.do")
  public String nationListData(Model model) 
  {
      List<NationVO> nations = iService.nationListData();
      model.addAttribute("nations", nations);
      return "nation/list";
  }

  // 생산지역 상세 페이지
  @GetMapping("nation/detail.do")
  public String nationDetailData(@RequestParam("no") int no, Model model) 
  {
      NationVO nation = iService.nationDetailData(no);
      model.addAttribute("nation", nation);
      return "nation/detail"; 
  }
  
  // 생산자 목록 
  @GetMapping("maker/list.do")
  public String makerListData(Model model) 
  {
      List<MakerVO> makers = iService.makerListData();
      model.addAttribute("makers", makers);
      return "maker/list"; 
  }

  // 생산자 상세 
  @GetMapping("maker/detail.do")
  public String makerDetailData(@RequestParam("no") int no, Model model) 
  {
      MakerVO maker = iService.makerDetailData(no);
      model.addAttribute("maker", maker);
      return "maker/detail"; 
  }
}
