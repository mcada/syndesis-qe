package io.syndesis.qe.pages.integrations.editor.add.connection.actions.database;

import static com.codeborne.selenide.Condition.exactText;
import static com.codeborne.selenide.Condition.visible;
import static com.codeborne.selenide.Selenide.$;

import org.openqa.selenium.By;

import com.codeborne.selenide.SelenideElement;

import lombok.extern.slf4j.Slf4j;

/**
 * Created by sveres on 12/6/17.
 */
@Slf4j
public class PeriodicSql extends Sql {

    private static final class Element {
        public static final By INPUT_QUERY = By.cssSelector("input[name='query']");
        public static final By INPUT_PERIOD = By.cssSelector("input[data-testid='schedulerexpression']");
        public static final By SELECT_PERIOD = By.cssSelector("[data-testid='schedulerexpression-duration']");
        public static final By TITLE = By.cssSelector("h3[innertext='Periodic SQL Invocation']");
    }

    @Override
    public void fillSqlInput(String query) {
        log.debug("filling sql query: {}", query);
        SelenideElement element = $(Element.INPUT_QUERY);
        this.fillInput(element, query);
    }

    @Override
    public boolean validate() {
        return this.getRootElement().find(Element.TITLE).is(visible);
    }

    public void fillSQLperiod(String period) {
        log.debug("filling sql period: {}", period);
        SelenideElement element = $(Element.INPUT_PERIOD).shouldBe(visible);
        this.fillInput(element, period);
    }

    public void selectSQLperiodUnits(String timeUnits) {
        log.debug("selecting sql period units: {}", timeUnits);
        SelenideElement selectElement = $(Element.SELECT_PERIOD).shouldBe(visible);
        selectElement.click();
        log.info(selectElement.toString());
        $(By.className("pf-c-dropdown__menu")).$$(By.tagName("li")).filter(exactText(timeUnits)).get(0).click();
       // selectElement.selectOption(timeUnits);
    }

}
