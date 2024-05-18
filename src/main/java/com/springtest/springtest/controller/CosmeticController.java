package com.springtest.springtest.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.springtest.springtest.model.Cosmetic;
import com.springtest.springtest.service.CosmeticService;

@RestController
@RequestMapping("/cosmetic")
@CrossOrigin

public class CosmeticController {
    @Autowired
    private CosmeticService cosmeticService;

    @PostMapping("/add")
    public String add(@RequestBody Cosmetic cosmetic){
        cosmeticService.saveCosmetic(cosmetic);
        return "New student is added";
    }

    @GetMapping("/getAll")
    public List<Cosmetic> getAllCosmetics(){
        return cosmeticService.getAllCosmetics();
    }
}