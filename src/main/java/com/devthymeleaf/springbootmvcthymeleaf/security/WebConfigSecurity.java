package com.devthymeleaf.springbootmvcthymeleaf.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class WebConfigSecurity extends WebSecurityConfigurerAdapter{

	@Override // Configura as solicitações de acesso por Http
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable()
			.authorizeRequests()
			.antMatchers("admin/**", "/admin/**") .hasAnyRole("ADMIN")

			.anyRequest().authenticated()
			.and().formLogin().permitAll()
			.loginPage("/login")
			.defaultSuccessUrl("/admin/pessoas")
			.failureUrl("/login?error=true")
			.and().logout().logoutSuccessUrl("/login")
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"));

	}


	@Override // Cria autenticação do usuário com banco de dados ou em memória
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		//unique user
		auth.inMemoryAuthentication().passwordEncoder(new BCryptPasswordEncoder())
			.withUser("admin")
			.password("$2a$10$XQ44XYOBateY8V.sHCgmhOqh8u6PxaUjKgRfIj2Xu1x9.yqHV9cty")
			.roles("ADMIN");

	}

}