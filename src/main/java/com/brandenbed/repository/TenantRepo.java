package com.brandenbed.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.brandenbed.entity.TenantQuery;

@Repository
public interface TenantRepo  extends JpaRepository<TenantQuery, Long>{

	List<TenantQuery> findTop5ByOrderByDateSubmittedDesc();
	long countByStatus(TenantQuery.Status status);


}
