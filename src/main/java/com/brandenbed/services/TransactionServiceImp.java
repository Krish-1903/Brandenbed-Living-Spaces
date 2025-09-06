package com.brandenbed.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.brandenbed.entity.Transaction;
import com.brandenbed.repository.TransactionRepo;

@Service
public class TransactionServiceImp implements TransactionService  {
	
	private final TransactionRepo transactionRepo;

	public TransactionServiceImp(TransactionRepo transactionRepo) {
		this.transactionRepo = transactionRepo;
	}

	@Override
	public List<Transaction> findAll() {
		// TODO Auto-generated method stub
		return transactionRepo.findAll();
	}

	@Override
    public Page<Transaction> findAll(Pageable pageable) {
        // Fetch paginated transactions from DB
        return transactionRepo.findAll(pageable);
    }

	@Override
	public Page<Transaction> findByStatus(String status, PageRequest of) {
		// TODO Auto-generated method stub
		return transactionRepo.findByStatus(status, of);
	}

	@Override
	public List<Transaction> findTop5ByStatusOrderByTransactionDateAsc(String status) {
		// TODO Auto-generated method stub
		return transactionRepo.findTop5ByStatusOrderByTransactionDateAsc(status);
	}

	@Override
	public Double sumAmountByStatus(String status) {
		// TODO Auto-generated method stub
		return transactionRepo.sumAmountByStatus(status);
	}
	
	 public List<Transaction> getTop5PendingRents() {
	        return transactionRepo.findTop5ByStatusOrderByTransactionDateAsc("Pending");
	    }

	@Override
	public Double getTotalPendingRent() {
		// TODO Auto-generated method stub
		return transactionRepo.sumAmountByStatus("Pending");
	}

	
	

}
