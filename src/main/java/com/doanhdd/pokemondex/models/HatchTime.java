package com.doanhdd.pokemondex.models;

public class HatchTime {
	private Integer steps;
	private Integer cycles;

	public HatchTime(Integer steps, Integer cycles) {
		super();
		this.steps = steps;
		this.cycles = cycles;
	}

	public Integer getSteps() {
		return steps;
	}

	public void setSteps(Integer steps) {
		this.steps = steps;
	}

	public Integer getCycles() {
		return cycles;
	}

	public void setCycles(Integer cycles) {
		this.cycles = cycles;
	}

}
