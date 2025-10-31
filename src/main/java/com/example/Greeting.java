package com.example;

public class Greeting {
    public String sayHello(String name) {
        if (name == null) {
            return "Hello, Friend";
        }
        return "Hello, " + name;
    }
}
