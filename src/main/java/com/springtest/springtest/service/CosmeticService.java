package com.springtest.springtest.service;

import java.util.List;
import java.util.Optional;

import com.springtest.springtest.model.Cosmetic;

public interface CosmeticService {
    public Cosmetic saveCosmetic(Cosmetic cosmetic);

    public List<Cosmetic> getAllCosmetics();

    Optional<Cosmetic> getCosmeticById(Integer id);
}
