package com.devthymeleaf.springbootmvcthymeleaf.resources;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import com.devthymeleaf.springbootmvcthymeleaf.service.ReportService;

@Controller
public class ReportResource {

    @Autowired
	private ReportService reportUtil;

    @GetMapping("**/admin/imprimirRelatorio")
	public void imprimePdf(HttpServletRequest req, HttpServletResponse res) throws Exception {

		reportUtil.criarImpressao(req, res);

	}


}
