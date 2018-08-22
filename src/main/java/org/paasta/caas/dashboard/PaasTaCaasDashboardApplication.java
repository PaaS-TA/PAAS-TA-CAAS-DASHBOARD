package org.paasta.caas.dashboard;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication
public class PaasTaCaasDashboardApplication {

	public static void main(String[] args) {
		SpringApplication.run(PaasTaCaasDashboardApplication.class, args);
	}
}
