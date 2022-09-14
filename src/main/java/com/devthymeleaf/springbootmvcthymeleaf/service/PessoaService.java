package com.devthymeleaf.springbootmvcthymeleaf.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.devthymeleaf.springbootmvcthymeleaf.model.Pessoa;
import com.devthymeleaf.springbootmvcthymeleaf.repository.PessoaRepository;
import com.devthymeleaf.springbootmvcthymeleaf.repository.ProfissaoRepository;
import com.devthymeleaf.springbootmvcthymeleaf.repository.TelefoneRepository;

@Service
public class PessoaService {

    @Autowired
	private PessoaRepository pessoaRepository;

    @Autowired
	private TelefoneRepository telefoneRepository;

    @Autowired
	private ProfissaoRepository profissaoRepository;

    public Object findAll(int page) {

        var pessoas = pessoaRepository.findAll(PageRequest.of(page, 5, Sort.Direction.ASC, "id"));

        return addObjects(pessoas, new Pessoa(), null, null);

    }

    public Object findAllBySearch(String nome, int page) {

        //findAll com páginação da pág vinda com param get e nome vindo com param nomepesquisa
        var pessoas = pessoaRepository.listarAllByNamePage(nome.trim().toUpperCase(),
            PageRequest.of(page, 5, Sort.Direction.ASC, "id"));


        //adiciona objetos para tela(thymeleaf)
        return addObjects(pessoas, new Pessoa(), nome, null);

    }

    public Object save(Pessoa pessoa, BindingResult bindingResult, MultipartFile file) throws IOException {

        //evita erro de cascade do relacionamento
		pessoa.setTelefones(telefoneRepository.getTelefones(pessoa.getId()));

        if (//se tiver email igual e se esse email for diferente desse usuario
            (pessoaRepository.verificarEmail(pessoa.getEmail()) != null && !pessoaRepository.verificarEmail(pessoa.getEmail()).isEmpty())
            && (!pessoaRepository.emailById(pessoa.getId()).equals(pessoa.getEmail()))
        ) { return emailHandler(pessoa); }

        // se houver erros vindo da validacao do modelo(javax.validation)
        if (bindingResult.hasErrors()) { return validarObjecto(pessoa, bindingResult); }

        //faz verificações para manter ou não manter arq na tbl
        patchFiles(pessoa, file);

        pessoaRepository.save(pessoa);// salva os dados

        return "redirect:/admin/pessoas";

    }

    public Object editar(long id) {

		var pessoas = pessoaRepository.findAll(PageRequest.of(0, 5, Sort.Direction.ASC, "id"));

		var pessoaObj = pessoaRepository.findById(id).get();// passa para a tela os dados do id pra carrega no form

        return addObjects(pessoas, pessoaObj, null, null);

    }

    public Object loadImg(long id) {

        //só precisa do objeto pessoa, por isso não usamos metodo addObjects, além da tela ser outra
        return new ModelAndView("cadastro/editarImg")
            .addObject("pessoaobj", pessoaRepository.findById(id).get());

    }

    public void salvarImg(Pessoa pessoaNova) {

        var pessoaSalva = pessoaRepository.findById(pessoaNova.getId()).orElseThrow(() -> new IllegalArgumentException());

        var img = pessoaNova.getImagem();//salvando em uma var antes da copia, já que este atributo será apagado na copia

        //coloca dados do obj antigo para o novo, já que aqui apenas apenas o atributo imagem está nele, assim tendo um tipo de patch
		BeanUtils.copyProperties(pessoaSalva, pessoaNova, "id");

        pessoaSalva.setImagem(img);

		pessoaRepository.save(pessoaSalva);

    }

    public Object delete(long id) {

        pessoaRepository.deleteById(id);// deleta os dados

        return "redirect:/admin/pessoas";

    }

    public void download(long id, HttpServletResponse res) throws IOException {

        // consultar o objeto pessoa no banco de dados
		Pessoa pessoa = pessoaRepository.findById(id).get();
		if (pessoa.getArquivo() != null) {// se exitir arquivo pra fazer download

			// setar tamanho da resposta
			res.setContentLength(pessoa.getArquivo().length);

			// tipo do arquivo para download ou pode ser generica application/octet-stream
			res.setContentType(pessoa.getTipoFileArquivo());

			// define o cabecalho da resposta
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", pessoa.getNomeFileArquivo());
			res.setHeader(headerKey, headerValue);

			// finaliza a resposta passando o arquivo
			res.getOutputStream().write(pessoa.getArquivo());

		}

    }






















    private Object addObjects(Page<Pessoa> pessoas, Pessoa pessoaObj, String nomepesquisa, String msg) {

        var view = new ModelAndView("cadastro/cadastroPessoa");

        // Lista de pessoas
		view.addObject("pessoas", pessoas);

		// para edicao
		view.addObject("pessoaobj", pessoaObj);

		// passa o nome pesquisado para manter form e páginar com ele
		view.addObject("nomepesquisa", nomepesquisa);

		view.addObject("profissoes", profissaoRepository.findAll());

        view.addObject("msg", msg);

        return view;

    }

    private Object validarObjecto(Pessoa pessoa, BindingResult bindingResult) {

        var msg = new ArrayList<String>();
        for (ObjectError objectError : bindingResult.getAllErrors()) {
            msg.add(objectError.getDefaultMessage());//mostrara os erros vindos javax.validation
        }

        var pessoas = pessoaRepository.findAll(PageRequest.of(0, 5, Sort.Direction.ASC, "id"));

        return addObjects(pessoas, pessoa, null, msg.toString());

    }

    private Object emailHandler(Pessoa pessoa) {

        var pessoas = pessoaRepository.findAll(PageRequest.of(0, 5, Sort.Direction.ASC, "id"));

        return addObjects(pessoas, pessoa, null, "E-Mail já está em uso!");

    }

    private void patchFiles(Pessoa pessoa, MultipartFile file) throws IOException {

        //se tiver arquivo grava
        if (file.getSize() > 0) {

            pessoa.setArquivo(file.getBytes());
            pessoa.setTipoFileArquivo(file.getContentType());
            pessoa.setNomeFileArquivo(file.getOriginalFilename());

            //form não envia imagem, se estiver editando mantem-a
            pessoa.setImagem(pessoaRepository.findById(pessoa.getId()).get().getImagem());

        } else if(pessoa.getId() != null && pessoa.getId() > 0)
            {//se não tiver arquivo mas tiver id, mantem-o

                Pessoa pessoaTempo = pessoaRepository.findById(pessoa.getId()).get();

                pessoa.setArquivo(pessoaTempo.getArquivo());
                pessoa.setTipoFileArquivo(pessoaTempo.getTipoFileArquivo());
                pessoa.setNomeFileArquivo(pessoaTempo.getNomeFileArquivo());

                //form não envia imagem, se estiver editando mantem-a
                pessoa.setImagem(pessoaTempo.getImagem());

        }

    }

}