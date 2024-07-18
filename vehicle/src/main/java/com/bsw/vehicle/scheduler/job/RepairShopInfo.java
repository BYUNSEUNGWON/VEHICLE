package com.bsw.vehicle.scheduler.job;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class RepairShopInfo {
	
	// 30초마다
	@Scheduled(fixedDelay = 30000)
	public void run() {
		System.out.println("스케줄러 실행중");
	}

}
