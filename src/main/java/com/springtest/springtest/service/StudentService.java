package com.springtest.springtest.service;

import java.util.List;

import com.springtest.springtest.model.Student;

public interface StudentService {
    public Student saveStudent(Student student);
    public List<Student> getAllStudents();
}
