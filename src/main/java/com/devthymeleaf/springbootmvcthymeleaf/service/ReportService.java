package com.devthymeleaf.springbootmvcthymeleaf.service;

import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.devthymeleaf.springbootmvcthymeleaf.model.Pessoa;
import com.devthymeleaf.springbootmvcthymeleaf.repository.PessoaRepository;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Service
public class ReportService {

	@Autowired
	private PessoaRepository pessoaRepository;

	public void criarImpressao(HttpServletRequest request, HttpServletResponse response) throws Exception {

		var pessoas = new ArrayList<Pessoa>();

		Iterable<Pessoa> iterator = pessoaRepository.listarAll();

		for (Pessoa pessoa : iterator) {
			pessoas.add(pessoa);
		}

		// chamar o serviço que faz a geraçao do relatorio
		byte[] pdf = gerarRelatorio(pessoas, "pessoa", request.getServletContext());

		// tamanho da resposta para o navegador
		response.setContentLength(pdf.length);

		// definir na resposta o tipo de arquivo
		response.setContentType("application/octet-stream");

		// difinir o cabecalho da resposta
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"", "relatorio.pdf");
		response.setHeader(headerKey, headerValue);

		// finaliza a resposta pro navegador
		response.getOutputStream().write(pdf);



	}



	//retorna o PDF em Bytes para download no navegador
	public byte[] gerarRelatorio(List listDados, String relatorio, ServletContext servletContext) throws Exception {

		//cria a lista de dados para o relatorio com nossa lista de objetos para imprimir
		JRBeanCollectionDataSource jrbcds = new JRBeanCollectionDataSource(listDados);

		var file = this.getClass().getResourceAsStream(
				"/WEB-INF/report/" + File.separator + relatorio + ".jasper");

		//carrega o arquivo jasper passando os dados
		JasperPrint impressoraJasper = JasperFillManager.fillReport(file, new HashMap(), jrbcds);

		//exporta para byte para fazer download do PDF
		return JasperExportManager.exportReportToPdf(impressoraJasper);

	}




}
