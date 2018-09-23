package com.github.slamdev.catalog.inventory.business.control;

import com.github.slamdev.catalog.inventory.business.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ProductRepository extends JpaRepository<Product, UUID> {
}
