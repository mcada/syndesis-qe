package io.syndesis.qe.pages.login;

import static com.codeborne.selenide.Selenide.$;

import org.openqa.selenium.By;

import com.codeborne.selenide.Condition;

public class RHDevLogin implements Login {
    private static final class Button {
        public static final By SIGNIN = By.id("kc-login");
        public static final By NEXT = By.id("login-show-step2");
    }

    private static final class Input {
        public static final By USERNAME = By.id("username");
        public static final By PASSWORD = By.id("password");
    }

    public void login(String username, String password) {
        $(Input.USERNAME).shouldBe(Condition.visible).setValue(username);
        $(Button.NEXT).shouldBe(Condition.visible).click();
        $(Input.PASSWORD).shouldBe(Condition.visible).setValue(password);
        $(Button.SIGNIN).shouldBe(Condition.visible).click();
    }
}
