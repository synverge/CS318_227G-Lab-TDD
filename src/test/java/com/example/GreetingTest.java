package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class GreetingTest {
    @Test
    void testHelloBasic() {
        // 1. Arrange
        Greeting greeting = new Greeting();

        // 2. Act
        String result = greeting.sayHello("World");

        // 3. Assert
        assertEquals("Hello, World", result);
    }
}
