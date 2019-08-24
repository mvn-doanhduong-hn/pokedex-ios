package com.doanhdd.pokemondex.models;

public class PokemonDetailModel {

	private Pokemon pokemon;
	private StatsModel stats;
	private EvolutionModel evolutions;
	private MoveModel moves;

	public Pokemon getPokemon() {
		return pokemon;
	}

	public void setPokemon(Pokemon pokemon) {
		this.pokemon = pokemon;
	}

	public StatsModel getStats() {
		return stats;
	}

	public void setStats(StatsModel stats) {
		this.stats = stats;
	}

	public EvolutionModel getEvolutions() {
		return evolutions;
	}

	public void setEvolutions(EvolutionModel evolutions) {
		this.evolutions = evolutions;
	}

	public MoveModel getMoves() {
		return moves;
	}

	public void setMoves(MoveModel moves) {
		this.moves = moves;
	}

}
