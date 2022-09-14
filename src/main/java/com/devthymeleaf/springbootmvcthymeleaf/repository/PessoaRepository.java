package com.devthymeleaf.springbootmvcthymeleaf.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.devthymeleaf.springbootmvcthymeleaf.model.Pessoa;

@Repository
@Transactional
public interface PessoaRepository extends JpaRepository<Pessoa, Long> {

	//lista todos os usuarios ordenado por id
	@Query(value = "select u from Pessoa u ORDER BY u.id")
	List<Pessoa> listarAll();

	//email de um determinado id
	@Query(value = "SELECT m.email FROM Pessoa m WHERE m.id = ?1")
	String emailById(Long id);

	//verificando se ja existe o email passado
	@Query(value = "SELECT m FROM Pessoa m WHERE m.email = ?1")
	List<Pessoa> verificarEmail(String email);

	//query de pesquisa com paginação
	@Query(value = "select x from Pessoa x where trim(upper(x.nome)) like %?1% ")
	Page<Pessoa> listarAllByNamePage(String nome, Pageable pageable);

}