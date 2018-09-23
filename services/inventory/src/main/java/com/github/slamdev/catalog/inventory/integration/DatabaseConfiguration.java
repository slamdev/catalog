package com.github.slamdev.catalog.inventory.integration;

import lombok.extern.slf4j.Slf4j;
import org.flywaydb.core.Flyway;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.flyway.FlywayAutoConfiguration;
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationInitializer;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

@Slf4j
@Configuration
@AutoConfigureBefore({DataSourceAutoConfiguration.class, FlywayAutoConfiguration.class})
public class DatabaseConfiguration {

    private static final String SYSTEM_DATABASE = "system";

    @Bean
    public FlywayMigrationInitializer flywayInitializer(Flyway flyway, DataSourceProperties properties) {
        createDatabaseIfNotExists(properties);
        return new FlywayMigrationInitializer(flyway, null);
    }

    private void createDatabaseIfNotExists(DataSourceProperties properties) {
        DataSourceProperties rootProperties = new DataSourceProperties();
        String databaseName = getDatabaseFromUrl(properties.getUrl());
        rootProperties.setUrl(properties.getUrl().replace(databaseName, SYSTEM_DATABASE));
        rootProperties.setUsername(properties.getUsername());
        DataSource dataSource = rootProperties.initializeDataSourceBuilder().build();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        jdbcTemplate.execute("CREATE DATABASE IF NOT EXISTS " + databaseName);
    }

    private String getDatabaseFromUrl(String url) {
        String[] parts = url.split("/");
        return parts[parts.length - 1].split("\\?")[0];
    }
}
