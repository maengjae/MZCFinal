package com.springtest.springtest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springtest.springtest.model.Cosmetic;
import com.springtest.springtest.repository.CosmeticRepository;

@Service
public class CosmeticServiceImpl implements CosmeticService{

    @Autowired
    private CosmeticRepository cosmeticRepository;

    @Override
    public Cosmetic saveCosmetic(Cosmetic cosmetic) {
        return cosmeticRepository.save(cosmetic);
    }

    @Override
    public List<Cosmetic> getAllCosmetics() {
        return cosmeticRepository.findAll();
    }
}
