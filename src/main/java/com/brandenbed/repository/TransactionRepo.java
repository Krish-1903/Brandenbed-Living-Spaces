package com.brandenbed.repository;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.brandenbed.entity.Transaction; // your entity

@Repository
public interface TransactionRepo extends JpaRepository<Transaction, Long> {

	List<Transaction> findTop5ByStatusOrderByTransactionDateAsc(String status);


	Page<Transaction> findByStatus(String status, PageRequest of);
	
	// Sum of all pending rents
    @Query("SELECT COALESCE(SUM(t.amount), 0) FROM Transaction t WHERE t.status = 'Pending'")
    double getTotalPendingRent();


    // Sum of pending transactions
    @Query("SELECT COALESCE(SUM(t.amount), 0) FROM Transaction t WHERE t.status = :status")
    Double sumAmountByStatus(String status);


   

	
}
