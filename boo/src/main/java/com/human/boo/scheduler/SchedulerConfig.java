/**
 * 이 클래스는 필요한 데이터를 공공 api에서 크롤링하는 스케쥴러이다.
 * @author  김광섭
 * @since	2024.05.29
 * @version V.1.0
 * 			2024.05.29 - 스케쥴러 클래스 제작 [ 담당자 : 김광섭 ] 
 */
package com.human.boo.scheduler;

import org.springframework.context.annotation.*;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;

/**
 * 이 클래스는 지정시간에 데이터 추가를 위해 Django서버에 요청을 하기 위한 Scheduler 클래스
 * @author	김광섭
 * @version v.2.9
 * 	클래스 제작 [ 담당자 : 김광섭 ]
 */

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