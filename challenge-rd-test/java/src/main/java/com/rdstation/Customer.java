package com.rdstation;

public class Customer {

    private final int id;
    private final int score;

    public Customer(int id, int score) {
        this.id = id;
        this.score = score;
    }

    public int getId() {
        return id;
    }

    public int getScore() {
        return score;
    }
}
