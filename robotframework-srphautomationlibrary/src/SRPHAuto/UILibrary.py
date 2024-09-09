from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager, DriverManager
from robot.api.deco import keyword
from selenium.webdriver.common.by import By
from robot.utils.robotpath import abspath
from selenium.webdriver.chrome.options import Options
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.action_chains import ActionChains, ScrollOrigin
from time import time
import os, random, string, tempfile, re

built_in = BuiltIn()
service = ChromeService()
options = webdriver.ChromeOptions()

class UILibrary:

    @keyword("Install Webdriver")
    def install_webdriver(self, browser):
        """Installs webdriver within the browser.
        :param browser:   specifies type of webdriver to download.
        """
        if browser == 'Chrome':
            driver = webdriver.Chrome(service=service, options=options)
            return driver
    
    @keyword("Check If Chrome Driver Is Compatible")
    def return_chrome_browser_version(self):
        driver = webdriver.Chrome(service=service, options=options)
        chrome_browser_version = driver.capabilities['browserVersion']
        chrome_driver_version = driver.capabilities['chrome']['chromedriverVersion']
        print("browser: " + chrome_browser_version + " | driver: " + chrome_driver_version)
        is_compatible = chrome_browser_version[0:3]==chrome_driver_version[0:3]
        return is_compatible
    
    @keyword("Mouse Scroll")
    def mouse_scroll(self, x=0, y=0):
        """Scroll the mouse wheel.
        :param x: (int) Distance along X axis to scroll using the wheel. A negative value scrolls left.
        :param y: (int) Distance along Y axis to scroll using the wheel. A negative value scrolls up.
        """
        driver = built_in.get_library_instance("SeleniumLibrary").driver
        actions = ActionChains(driver)
        actions.scroll_by_amount(x,y).perform()
    
    @keyword("Mouse Scroll Over Element")
    def mouse_scroll_over_element(self, locator, x=0, y=0):
        """Scroll the mouse wheel over an element indicated by `locator`.
        :param locator:  (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
        :param x: (int) Distance along X axis to scroll using the wheel. A negative value scrolls left.
        :param y: (int) Distance along Y axis to scroll using the wheel. A negative value scrolls up.
        """
        driver = built_in.get_library_instance("SeleniumLibrary").driver
        actions = ActionChains(driver)
        element = driver.find_element(By.XPATH, locator)
        scroll_origin = ScrollOrigin.from_element(element)
        actions.scroll_from_origin(scroll_origin, x, y).perform()
    
    @keyword("Wait Until Window Opens")
    def wait_until_window_opens(self, title, timeout=None):
        """Used to get the titles of the current browser windows, then verify that the provided window title
        is among them.
        :param title: (string) The title of the window you are waiting for.
        :param timeout: (float) Time in seconds to wait, will use global timeout if not set.
        """
        selenium_instance = built_in.get_library_instance("SeleniumLibrary")
        timeout = time() + float(timeout) if timeout else time() + selenium_instance.timeout
        while time() < timeout:
            titles = selenium_instance.get_window_titles()
            if title in titles:
                return
        built_in.fail("Window with title '%s' not found." % (title))
    
    @keyword("Scroll To Bottom Of Page")
    def scroll_to_bottom_of_page(self):
        """This keyword scrolls down to the bottom of the page, if jquery is not available it will scroll 20000 pixels
        """
        selenium_instance = built_in.get_library_instance("SeleniumLibrary")
        try:
            height = selenium_instance.execute_javascript("return window.outerHeight")
        except BaseException as ex: 
            if ex:
                height = 20000
        selenium_instance.execute_javascript(f"window.scrollTo(0,{height})")
    
    @keyword("Wait Until JQuery Is Complete")
    def wait_until_jquery_is_complete(self):
        """This keyword polls the jQuery.active flag, to track execution of AJAX requests. The web application needs
        to have jQuery in order for this to work.
        """
        selenium_instance = built_in.get_library_instance("SeleniumLibrary")
        for each in range(1, 20):
            jquery_started = selenium_instance.execute_javascript("return jQuery.active==1")
            if jquery_started:
                break
        for _ in range(1, 50):
            jquery_completed = selenium_instance.execute_javascript("return window.jQuery!=undefined && jQuery.active==0")
            if jquery_completed:
                break
            built_in.sleep("0.5s")
