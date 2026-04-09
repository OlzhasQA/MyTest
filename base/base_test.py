import pytest
from config.data import Data
from pages.login_page import LoginPage
from pages.personal_page import PersonalPage
from pages.dashboard_page import DashboardPage

#сделаем нотация типов

class BaseTest:

    data: Data

    login_page: LoginPage
    personal_page: PersonalPage
    dashboard_page: DashboardPage

    @pytest.fixture(autouse=True)
    def setup(self, request, driver):
        request.cls.driver = driver
        request.cls.data = Data()

        request.cls.login_page = LoginPage(driver)
        request.cls.personal_page = PersonalPage(driver)
        request.cls.dashboard_page = DashboardPage(driver)


