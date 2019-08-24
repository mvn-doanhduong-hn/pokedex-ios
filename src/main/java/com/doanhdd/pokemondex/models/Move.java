package com.doanhdd.pokemondex.models;

import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

public class Move {
	private String name;
	private PokemonType type;
	private String effects;
	private Integer power;
	private String accuracy;
	private Integer pp;

	public Move() {
		super();
	}

	public Move(String name, PokemonType type) {
		super();
		this.name = name;
		this.type = type;
	}

	public Move(String name, PokemonType type, String effects, Integer power, String accuracy, Integer pp) {
		super();
		this.name = name;
		this.type = type;
		this.effects = effects;
		this.power = power;
		this.accuracy = accuracy;
		this.pp = pp;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public PokemonType getType() {
		return type;
	}

	public void setType(PokemonType type) {
		this.type = type;
	}

	public String getEffects() {
		return effects;
	}

	public void setEffects(String effects) {
		this.effects = effects;
	}

	public Integer getPower() {
		return power;
	}

	public void setPower(Integer power) {
		this.power = power;
	}

	public String getAccuracy() {
		return accuracy;
	}

	public void setAccuracy(String accuracy) {
		this.accuracy = accuracy;
	}

	public Integer getPp() {
		return pp;
	}

	public void setPp(Integer pp) {
		this.pp = pp;
	}

	public static List<Move> getMoves() {
		List<Move> moves = new ArrayList<Move>();
		moves.add(new Move("Absorb", PokemonType.GRASS,
				"Absorb deals damage and the user will recover 50% of the HP drained.\r\n"
						+ "If the user is holding a Big Root, the move instead recovers 65% of the damage dealt (30% more than normal). If used on a Pokémon with the ability Liquid Ooze, the user instead loses the HP it would have otherwise gained.",
				20, "100", 25));
		moves.add(new Move("Accelerock", PokemonType.ROCK, "Accelerock deals damage and has high priority.\r\n"
				+ "Moves with a higher priority always go first, regardless of a Pokémon's speed. If two moves with the same priority are used, the faster Pokémon goes first as usual.",
				40, "100", 20));
		return moves;
	}
	
	public static List<Move> getMoves(String name) {
		List<Move> moves = getMoves();
		if (StringUtils.isEmpty(name)) {
			return moves;
		}
		List<Move> results = new ArrayList<Move>();
		for (Move move : moves) {
			if (move.getName().toLowerCase().contains(name.toLowerCase())) {
				results.add(move);
			}
		}
		return results;
	}
	
	public static Move getMove(String name) {
		if (StringUtils.isEmpty(name)) {
			return null;
		}
		
		List<Move> moves = getMoves();
		for (Move move : moves) {
			if (move.getName().toLowerCase().equals(name.toLowerCase())) {
				return move;
			}
		}
		return null;
	}
}
