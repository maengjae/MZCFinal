package com.springtest.springtest.service;

import java.util.List;

import com.springtest.springtest.model.Cosmetic;

public interface CosmeticService {
    public Cosmetic saveCosmetic(Cosmetic cosmetic);
    public List<Cosmetic> getAllCosmetics();
}
