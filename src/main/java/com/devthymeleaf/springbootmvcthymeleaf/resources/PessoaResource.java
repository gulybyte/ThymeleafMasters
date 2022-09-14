package com.devthymeleaf.springbootmvcthymeleaf.resources;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.devthymeleaf.springbootmvcthymeleaf.model.Pessoa;
import com.devthymeleaf.springbootmvcthymeleaf.service.PessoaService;

@Controller
public class PessoaResource {

	@Autowired
	private PessoaService pessoaService;

	@GetMapping("/admin/pessoas")//retorna pág CRUD com os dados
	public Object findPessoaPage(@RequestParam(value = "page", required = false,
			defaultValue = "0") int page) {

		return pessoaService.findAll(page);

	}

	@GetMapping("/admin/pessoasSearch")// retorna pessoas que tiverem este nome
	public Object findPessoaPageSearch(@RequestParam("nomepesquisa") String nome,
			@RequestParam(value = "page", required = false, defaultValue = "0") int page) {

		return pessoaService.findAllBySearch(nome, page);

	}

	@PostMapping(value = "/admin/salvarPessoa", consumes = { "multipart/form-data" })//salva ou atualiza uma pessoa (criar PUT depois)
	public Object salvar(Pessoa pessoa, BindingResult bindingResult, final MultipartFile file) throws IOException {

		return pessoaService.save(pessoa, bindingResult, file);

	}

	@GetMapping("/admin/editarPessoa/{idpessoa}")//carrega dados de uma pessoa no form para atualizar
	public Object editarPessoa(@PathVariable("idpessoa") Long idpessoa) {

		return pessoaService.editar(idpessoa);

	}

	@GetMapping("/admin/imagem/{idpessoa}")
	public Object carregarImagem(@PathVariable("idpessoa") Long idpessoa) {

		return pessoaService.loadImg(idpessoa);

	}


	@PostMapping(value = "**/admin/FileUpload")
	@ResponseBody
	public void salvarImagem(@RequestBody Pessoa pessoa) {

		pessoaService.salvarImg(pessoa);

	}

	@GetMapping("**/admin/deletarpessoa/{idpessoa}")
	public Object deletarPessoa(@PathVariable("idpessoa") Long idpessoa) {

		return pessoaService.delete(idpessoa);

	}

	@GetMapping("**/admin/baixarArquivo/{idpessoa}")
	public void baixarArquivo(@PathVariable("idpessoa") Long idpessoa, HttpServletResponse response)
			throws IOException {

		pessoaService.download(idpessoa, response);

	}

}
