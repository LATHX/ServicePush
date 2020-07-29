package com.service.push.server;

import cucumber.api.java.en.Given;
import cucumber.api.java8.En;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;

public class ATest implements En {
    TestController testController = new TestController();
    String name;
    public ATest(){
        Given("Call {string}", (String string) -> {
            // Write code here that turns the phrase above into concrete actions
            this.name = string;
        });

        Then("Receive content {string}", (String string) -> {
            // Write code here that turns the phrase above into concrete actions
            Assert.assertEquals(name, testController.aaa());
        });
    }
}
