package com.doanhdd.pokemondex.models;

import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

public class Item {

	private String name;
	private Integer price;
	private String image;
	private String effects;

	public Item() {
		super();
	}

	public Item(String name, Integer price, String image, String effects) {
		super();
		this.name = name;
		this.price = price;
		this.image = image;
		this.effects = effects;
	}

	public static List<Item> getItems() {
		List<Item> items = new ArrayList<Item>();
		items.add(new Item("Beast Ball", 1000, "https://img.pokemondb.net/sprites/items/beast-ball.png",
				"A special Poké Ball designed to catch Ultra Beasts. It has a low success rate for catching others."));
		items.add(new Item("Love Ball", 0, "https://img.pokemondb.net/sprites/items/love-ball.png",
				"Poké Ball for catching Pokémon that are the opposite gender of your Pokémon."));
		items.add(new Item("Lure Ball", 200, "https://img.pokemondb.net/sprites/items/lure-ball.png",
				"A Poké Ball for catching Pokémon hooked by a Rod when fishing."));
		items.add(new Item("Luxury Ball", 200, "https://img.pokemondb.net/sprites/items/luxury-ball.png",
				"A comfortable Poké Ball that makes a caught wild Pokémon quickly grow friendly."));
		items.add(new Item("Master Ball", 0, "https://img.pokemondb.net/sprites/items/master-ball.png",
				"The best Ball with the ultimate level of performance. It will catch any wild Pokémon without fail."));
		items.add(new Item("Poké Ball", 200, "https://img.pokemondb.net/sprites/items/poke-ball.png",
				"A device for catching wild Pokémon. It is thrown like a ball at the target. It is designed as a capsule system."));
		items.add(new Item("Premier Ball", 600, "https://img.pokemondb.net/sprites/items/premier-ball.png",
				"A somewhat rare Poké Ball that has been specially made to commemorate an event of some sort."));
		items.add(new Item("Quick Ball", 1200, "https://img.pokemondb.net/sprites/items/quick-ball.png",
				"A somewhat different Poké Ball that provides a better catch rate if it is used at the start of a wild encounter."));

		return items;
	}

	public static List<Item> getItems(String name) {
		List<Item> items = getItems();
		if (StringUtils.isEmpty(name)) {
			return items;
		}
		List<Item> results = new ArrayList<Item>();
		for (Item item : items) {
			if (item.getName().toLowerCase().contains(name.toLowerCase())
					|| item.getName().replace(" ", "").toLowerCase().contains(name.toLowerCase())
					|| item.getName().replace(" ", "-").toLowerCase().contains(name.toLowerCase())) {
				results.add(item);
			}
		}
		return results;
	}

	public static Item getItem(String name) {
		if (StringUtils.isEmpty(name)) {
			return null;
		}
		List<Item> items = getItems();
		for (Item item : items) {
			if (item.getName().toLowerCase().equals(name.toLowerCase())
					|| item.getName().replace(" ", "").toLowerCase().equals(name.toLowerCase())
					|| item.getName().replace(" ", "-").toLowerCase().equals(name.toLowerCase())) {
				return item;
			}
		}
		return null;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getEffects() {
		return effects;
	}

	public void setEffects(String effects) {
		this.effects = effects;
	}

}
