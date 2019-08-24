package com.doanhdd.pokemondex.models;

import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

public class Pokemon {

	private String id;
	private String name;
	private String image;
	private String description;
	private PokemonType[] pokemonTypes;

	public Pokemon() {
		super();
	}

	public Pokemon(String id, String name, String image, PokemonType[] pokemonTypes) {
		super();
		this.id = id;
		this.name = name;
		this.image = image;
		this.pokemonTypes = pokemonTypes;
	}

	public Pokemon(String id, String name, String image, String description, PokemonType[] pokemonTypes) {
		super();
		this.id = id;
		this.name = name;
		this.image = image;
		this.description = description;
		this.pokemonTypes = pokemonTypes;
	}

	public static List<Pokemon> getPokemons() {
		List<Pokemon> pokemons = new ArrayList<Pokemon>();
		pokemons.add(new Pokemon("001", "Bulbasaur", "https://img.pokemondb.net/sprites/sun-moon/icon/bulbasaur.png",
				new PokemonType[] { PokemonType.GRASS, PokemonType.POISON }));
		pokemons.add(new Pokemon("002", "Ivysaur", "https://img.pokemondb.net/sprites/sun-moon/icon/ivysaur.png",
				new PokemonType[] { PokemonType.GRASS, PokemonType.POISON }));
		pokemons.add(new Pokemon("003", "Venusaur", "https://img.pokemondb.net/sprites/sun-moon/icon/venusaur.png",
				new PokemonType[] { PokemonType.GRASS, PokemonType.POISON }));

		return pokemons;
	}
	
	public static List<Pokemon> getPokemons(String name) {
		List<Pokemon> pokemons = getPokemons();
		if (StringUtils.isEmpty(name)) {
			return pokemons;
		}
		List<Pokemon> results = new ArrayList<Pokemon>();
		for (Pokemon pokemon : pokemons) {
			if (pokemon.getName().toLowerCase().contains(name.toLowerCase())) {
				results.add(pokemon);
			}
		}
		return results;
	}
	
	public static Pokemon getPokemon(String id) {
		if (StringUtils.isEmpty(id)) {
			return null;
		}
		
		List<Pokemon> pokemons = getPokemons();
		for (Pokemon pokemon : pokemons) {
			if (pokemon.getId().toLowerCase().equals(id.toLowerCase())) {
				return pokemon;
			}
		}
		return null;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public PokemonType[] getPokemonTypes() {
		return pokemonTypes;
	}

	public void setPokemonTypes(PokemonType[] pokemonTypes) {
		this.pokemonTypes = pokemonTypes;
	}

}
