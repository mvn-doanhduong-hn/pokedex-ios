package com.doanhdd.pokemondex;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.doanhdd.pokemondex.models.Item;
import com.doanhdd.pokemondex.models.Move;
import com.doanhdd.pokemondex.models.Pokemon;
import com.doanhdd.pokemondex.models.Weakness;

@RestController
public class PokemondexController {

	@GetMapping(path = "/pokemons")
	public List<Pokemon> getPokemons() {
		return Pokemon.getPokemons();
	}

	@GetMapping(path = "/pokemons/search")
	public List<Pokemon> getPokemons(@RequestParam(name = "name", required = false) String name) {
		return Pokemon.getPokemons(name);
	}

	@GetMapping(path = "/pokemons/{id}")
	public Pokemon getPokemon(@PathVariable String id) {
		return Pokemon.getPokemon(id);
	}

	@GetMapping(path = "/moves")
	public List<Move> getMoves() {
		return Move.getMoves();
	}

	@GetMapping(path = "/moves/search")
	public List<Move> getMoves(@RequestParam(name = "name", required = false) String name) {
		return Move.getMoves(name);
	}

	@GetMapping(path = "/moves/{name}")
	public Move getMove(@PathVariable String name) {
		return Move.getMove(name);
	}

	@GetMapping(path = "/items")
	public List<Item> getItems() {
		return Item.getItems();
	}

	@GetMapping(path = "/items/search")
	public List<Item> getItems(@RequestParam(name = "name", required = false) String name) {
		return Item.getItems(name);
	}

	@GetMapping(path = "/items/{name}")
	public Item getItem(@PathVariable String name) {
		return Item.getItem(name);
	}

	@GetMapping(path = "/weaknesses/{pokemonType}")
	public List<Weakness> getWeaknesses(@PathVariable String pokemonType) {
		return Weakness.getWeakneses(pokemonType);
	}

}
