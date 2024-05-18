package com.springtest.springtest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.springtest.springtest.model.Cosmetic;

@Repository
public interface CosmeticRepository extends JpaRepository<Cosmetic, Integer> {

}
