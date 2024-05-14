package com.springtest.springtest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.springtest.springtest.model.Student;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {

}
