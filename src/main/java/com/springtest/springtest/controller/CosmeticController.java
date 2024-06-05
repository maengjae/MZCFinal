package com.springtest.springtest.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    public String add(@RequestBody Cosmetic cosmetic) {
        cosmeticService.saveCosmetic(cosmetic);
        return "New cosmetic is added";
    }

    @GetMapping("/getAll")
    public List<Cosmetic> getAllCosmetics() {
        return cosmeticService.getAllCosmetics();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<Cosmetic>> getCosmeticById(@PathVariable Integer id) {
        Optional<Cosmetic> cosmetic = cosmeticService.getCosmeticById(id);
        if (cosmetic != null) {
            return ResponseEntity.ok(cosmetic);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}