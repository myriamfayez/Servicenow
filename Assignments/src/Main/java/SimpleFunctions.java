package com.example;



 
public class SimpleFunctions {

    public String hello(String name) {
        return "Hello, " + name + "!";
    }

    public String checkEvenOrOdd(int number) {
        if (number % 2 == 0) {
            return number + " is Even";
        } else {
            return number + " is Odd";
        }
    }
}

