package com.springtest.springtest.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
@CrossOrigin

public class HealthCheckController {

    @GetMapping
    public String healthCheck() {
        return "OK!";
    }
}
