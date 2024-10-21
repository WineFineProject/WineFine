package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.ReportService;

@Controller
public class ReportController {
  @Autowired
  private ReportService rService;
  
  @GetMapping("admin/report.do")
  public String report()
  {
	  return "admin/report";
  }
}
