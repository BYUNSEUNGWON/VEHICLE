package com.bsw.vehicle.transaction.service;

import java.util.List;

import com.bsw.vehicl.model.Transaction;

public interface TransactionService {
	
	List<Transaction> getFirTransaction();  // 맨 처음 홍보 데이터 조회 메서드
    
    List<Transaction> getTransactionByPage(int pageNumber, int showCount);  // 페이지에 해당하는 홍보 데이터 조회 메서드

}
