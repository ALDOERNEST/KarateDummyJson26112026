package org.example;

import com.intuit.karate.junit5.Karate;

class AuthLoginTest {

    @Karate.Test
    Karate loginEndpointTests() {
        return Karate.run("classpath:auth-login.feature");
    }
}
