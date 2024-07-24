package com.bsw.vehicle.scheduler.job;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class RepairShopInfo {
	
	@Value("${api.url}")
    private String apiUrl;
    
	
	/*
	@Scheduled(fixedDelay = 3000000)
	public void run(){
		System.out.println("스케줄러 실행중");
	
		try {
		    URL url = new URL(apiUrl);
		    Map map = new HashMap();
		
		    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		    conn.setRequestMethod("GET");
		    conn.setRequestProperty("Content-type", "application/json");
		
		    System.out.println("Response code: " + conn.getResponseCode());
		
		    BufferedReader rd;
		
		    if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		    } else {
		        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		    }
		
		    StringBuilder sb = new StringBuilder();
		    String line;
		
		    while ((line = rd.readLine()) != null) {
		        sb.append(line);
		    }
		
		    rd.close();
		    conn.disconnect();
		
		    String responseJSON = sb.toString();
		
		    JSONParser parser = new JSONParser();
		    JSONObject responseObj = (JSONObject) parser.parse(responseJSON); 
		    JSONArray dataArray = (JSONArray) responseObj.get("data");

		    for (Object obj : dataArray) {
		        JSONObject data = (JSONObject) obj;
		        
		        map.put("manageOrgNm", (String) data.get("관리기관명"));
		        map.put("manageAgenNum", (String) data.get("관리기관전화번호"));
		        map.put("dataDt", (String) data.get("데이터기준일자"));
		        map.put("businessRegistDt", (String) data.get("사업등록일자"));
		        map.put("locationMapAddrNm", (String) data.get("소재지도로명주소"));
		        map.put("company", (String) data.get("자동차정비업체명"));
		        map.put("number", (String) data.get("전화번호"));
		        map.put("latitude", (String) data.get("위도"));
		        map.put("hardness", (String) data.get("경도"));
		        map.put("state", (Long) data.get("영업상태"));

		    }
		    
		} catch (Exception e) {
		    e.printStackTrace();
		}
	}
	*/
}
