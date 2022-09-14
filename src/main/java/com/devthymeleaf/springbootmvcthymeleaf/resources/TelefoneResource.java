package com.devthymeleaf.springbootmvcthymeleaf.resources;

import java.io.IOException;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.devthymeleaf.springbootmvcthymeleaf.model.Telefone;
import com.devthymeleaf.springbootmvcthymeleaf.service.TelefoneService;

@Controller
public class TelefoneResource {

    @Autowired
    private TelefoneService telefoneService;

    @GetMapping("**/admin/telefones/{idpessoa}")
	public Object telefones(Telefone telefone, @PathVariable("idpessoa") Long idPessoa) {

		return telefoneService.carregarTelefones(telefone, idPessoa);

	}

	@PostMapping("**/admin/addFonePessoa/{pessoaid}")
	public Object addFonePessoa(@Valid Telefone telefone, BindingResult bindingResult,
			@PathVariable("pessoaid") Long pessoaid) throws IOException {

        return telefoneService.salvarTelefone(telefone, bindingResult, pessoaid);

	}

	@GetMapping("**/admin/deletartelefone/{telefoneid}")
	public Object deletarTelefone(@PathVariable("telefoneid") Long telefoneid) {

		return telefoneService.deletarTelefone(telefoneid);

	}

}
