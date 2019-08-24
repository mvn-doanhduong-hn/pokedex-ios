package com.doanhdd.pokemondex.models;

import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

public class Weakness {

	private PokemonType pokemonType;
	private float damage;

	public Weakness() {
		super();
	}

	public Weakness(PokemonType pokemonType, float damage) {
		super();
		this.pokemonType = pokemonType;
		this.damage = damage;
	}

	public PokemonType getPokemonType() {
		return pokemonType;
	}

	public void setPokemonType(PokemonType pokemonType) {
		this.pokemonType = pokemonType;
	}

	public float getDamage() {
		return damage;
	}

	public void setDamage(float damage) {
		this.damage = damage;
	}

	public static List<Weakness> getWeakneses(String type) {
		List<Weakness> weaknesses = new ArrayList<Weakness>();
		PokemonType pokemonType = getPokemonType(type);
		if (pokemonType == null) {
			return weaknesses;
		}		
		switch (pokemonType) {
		case NORMAL:
			weaknesses.add(new Weakness(PokemonType.ROCK, 1.5f));
			weaknesses.add(new Weakness(PokemonType.GHOST, 0));
			weaknesses.add(new Weakness(PokemonType.STEEL, 1.5f));
			break;
		case FIRE:
			weaknesses.add(new Weakness(PokemonType.FIRE, 0.5f));
			weaknesses.add(new Weakness(PokemonType.WATER, 0.5f));
			weaknesses.add(new Weakness(PokemonType.GRASS, 2f));
			weaknesses.add(new Weakness(PokemonType.ICE, 2f));
			weaknesses.add(new Weakness(PokemonType.BUG, 2f));
			weaknesses.add(new Weakness(PokemonType.ROCK, 0.5f));
			weaknesses.add(new Weakness(PokemonType.DRAGON, 0.5f));
			weaknesses.add(new Weakness(PokemonType.STEEL, 2f));
			break;
		case WATER:
			weaknesses.add(new Weakness(PokemonType.FIRE, 2f));
			weaknesses.add(new Weakness(PokemonType.WATER, 0.5f));
			weaknesses.add(new Weakness(PokemonType.GRASS, 0.5f));
			weaknesses.add(new Weakness(PokemonType.GHOST, 0));
			weaknesses.add(new Weakness(PokemonType.FLYING, 2f));
			weaknesses.add(new Weakness(PokemonType.ROCK, 2f));
			weaknesses.add(new Weakness(PokemonType.DRAGON, 0.5f));
			break;
		case ELECTRIC:
			weaknesses.add(new Weakness(PokemonType.WATER, 2f));
			weaknesses.add(new Weakness(PokemonType.ELECTRIC, 0.5f));
			weaknesses.add(new Weakness(PokemonType.GRASS, 0.5f));
			weaknesses.add(new Weakness(PokemonType.GHOST, 0));
			weaknesses.add(new Weakness(PokemonType.FLYING, 2f));
			weaknesses.add(new Weakness(PokemonType.DRAGON, 0.5f));
			break;
		case GRASS:
			weaknesses.add(new Weakness(PokemonType.FIRE, 0.5f));
			weaknesses.add(new Weakness(PokemonType.WATER, 2f));
			weaknesses.add(new Weakness(PokemonType.GRASS, 0.5f));
			weaknesses.add(new Weakness(PokemonType.POISON, 0.5f));
			weaknesses.add(new Weakness(PokemonType.GROUND, 2f));
			weaknesses.add(new Weakness(PokemonType.FLYING, 0.5f));
			weaknesses.add(new Weakness(PokemonType.BUG, 0.5f));
			weaknesses.add(new Weakness(PokemonType.ROCK, 2f));
			weaknesses.add(new Weakness(PokemonType.DRAGON, 0.5f));
			weaknesses.add(new Weakness(PokemonType.STEEL, 0.5f));
			break;
		default:
			break;
		}
		return weaknesses;
	}

	private static PokemonType getPokemonType(String type) {
		if (!StringUtils.isEmpty(type)) {
			for (PokemonType pokemonType : PokemonType.values()) {
				if (pokemonType.name().toLowerCase().equals(type.toLowerCase())) {
					return pokemonType;
				}
			}
		}
		return null;
	}
}
