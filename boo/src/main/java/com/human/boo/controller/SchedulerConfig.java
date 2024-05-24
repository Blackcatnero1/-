package com.human.boo.controller;

import org.springframework.context.annotation.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;

@Configuration
@EnableScheduling
public class SchedulerConfig {

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @Scheduled(cron = "0 0 12 * * ?") // 매일 정오에 스케쥴러 실행
    public void callSalesEndpoint() {
        LocalDateTime currentTime = LocalDateTime.now();
        String url = "http://192.168.0.34:8000/sales";
        RestTemplate restTemplate = restTemplate();
        try {
            String result = restTemplate.getForObject(url, String.class);
            System.out.println("현재 시간: " + currentTime);
            System.out.println("스케쥴링에 성공하였습니다.");
        } catch (HttpServerErrorException e) {
        	System.out.println("현재 시간: " + currentTime);
            System.out.println("스케쥴링에 성공하였습니다.");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage().replaceAll("\n", " ").replaceAll("\r", " "));
        }
    }
}