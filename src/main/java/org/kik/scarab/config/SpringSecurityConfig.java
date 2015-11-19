package org.kik.scarab.config;

import org.kik.scarab.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

	/**
	 * <security:http pattern="/resources/**" security="none" />
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}

	@Bean
	public UserDetailsServiceImpl userDetailsService() {
		return new UserDetailsServiceImpl();
	}

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth)
			throws Exception {
		auth.userDetailsService(userDetailsService());
	}

	/**
	 * <security:access-denied-handler error-page="/denied"/>
	 */
	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		AccessDeniedHandlerImpl adh = new AccessDeniedHandlerImpl();
		adh.setErrorPage("/denied");
		return adh;
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		// @formatter:off
		http
			.authorizeRequests()
				.antMatchers("/login**").permitAll()
				.antMatchers("/admin**").hasRole("ADMIN")
				.antMatchers("/console/**").permitAll()
				.anyRequest().authenticated()
		.and()
			.formLogin()
				.loginPage("/login")
				.defaultSuccessUrl("/")
				.loginProcessingUrl("/j_spring_security_check")
				.failureUrl("/login?error")
				.usernameParameter("username")
				.passwordParameter("password")
		.and()
			.logout()
				.logoutUrl("/j_spring_security_logout")
				.logoutSuccessUrl("/login?logout")

			// .and()
			//	.csrf()
		;
		// @formatter:on

		// http.csrf().disable();
		// http.headers().frameOptions().disable();

	}
}