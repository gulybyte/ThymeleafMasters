package com.devthymeleaf.springbootmvcthymeleaf.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.servlet.ModelAndView;

import com.devthymeleaf.springbootmvcthymeleaf.model.Pessoa;
import com.devthymeleaf.springbootmvcthymeleaf.model.Telefone;
import com.devthymeleaf.springbootmvcthymeleaf.repository.PessoaRepository;
import com.devthymeleaf.springbootmvcthymeleaf.repository.TelefoneRepository;

@Service
public class TelefoneService {

    @Autowired
    private TelefoneRepository telefoneRepository;

    @Autowired
    private PessoaRepository pessoaRepository;


    public Object carregarTelefones(Telefone telefone, long id) {

		var pessoaTel = pessoaRepository.findById(id).get();
		telefone.setPessoa(pessoaTel);

		return addObjects(telefoneRepository.getTelefones(pessoaTel.getId()), 
            pessoaTel, null);

    }

    public Object salvarTelefone(Telefone telefone, BindingResult bindingResult, long id) throws IOException {

        if (bindingResult.hasErrors()) {
            return validarObjeto(id, bindingResult);
		}

		var pessoaTel = pessoaRepository.findById(id).get();
		telefone.setPessoa(pessoaTel);

		telefoneRepository.save(telefone);

		return addObjects(telefoneRepository.getTelefones(id), pessoaTel, null);

    }

    public Object deletarTelefone(long id) {

        Pessoa pessoa = telefoneRepository.findById(id).get().getPessoa();

		telefoneRepository.deleteById(id);

        return addObjects(telefoneRepository.getTelefones(pessoa.getId()),
            pessoa, null);

    }










    private Object addObjects(List<Telefone> telefones, Pessoa pessoaTel, List<String> msg) {

        var view = new ModelAndView("cadastro/telefones");

		view.addObject("telefones", telefones);
        view.addObject("telefoneobj", pessoaTel);// passa objeto pra mostar na tabela
        view.addObject("msg", msg);


        return view;

    }

    public Object validarObjeto(long id, BindingResult bindingResult) {

        var msg = new ArrayList<String>();
        for (ObjectError objectError : bindingResult.getAllErrors()) {
            msg.add(objectError.getDefaultMessage());
        }

        return addObjects(telefoneRepository.getTelefones(id), pessoaRepository.findById(id).get(), msg);

    }

}
