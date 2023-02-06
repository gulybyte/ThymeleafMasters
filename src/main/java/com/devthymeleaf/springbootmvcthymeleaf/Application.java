package com.devthymeleaf.springbootmvcthymeleaf;

import com.devthymeleaf.springbootmvcthymeleaf.generic.Generic;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.Ordered;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@EntityScan(basePackages = "com.devthymeleaf.springbootmvcthymeleaf.model")
@ComponentScan(basePackages =  "com.devthymeleaf.*")
@EnableJpaRepositories(basePackages = {"com.devthymeleaf.springbootmvcthymeleaf.repository"})
@EnableTransactionManagement
@EnableWebMvc
public class Application implements WebMvcConfigurer {

	public static void main(String[] args) throws Exception {

		SpringApplication.run(Application.class, args);

		Generic.coffee();

	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/login").setViewName("/login");
		registry.setOrder(Ordered.LOWEST_PRECEDENCE);
	}

}



















/*/*/