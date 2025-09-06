package com.brandenbed.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.brandenbed.entity.Transaction;

public interface TransactionService {


	List<Transaction> findAll();

	Page<Transaction> findAll(Pageable pageable);

	Page<Transaction> findByStatus(String status, PageRequest of);

	List<Transaction> findTop5ByStatusOrderByTransactionDateAsc(String string);

	Double sumAmountByStatus(String string);

	Double getTotalPendingRent();

}
