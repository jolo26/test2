from visual_regression_tracker import VisualRegressionTracker, Config, TestRun, TestRunStatus
from robot.api.deco import keyword, not_keyword
from robot.libraries.BuiltIn import BuiltIn
from multipledispatch import dispatch
import base64

built_in = BuiltIn()

class ImageComparisonLibrary:
    
    @not_keyword
    def image_to_base64(image_path):
        with open(image_path, "rb") as image_file:
            image_data = image_file.read()
            base64_data = base64.b64encode(image_data)
            base64_string = base64_data.decode("utf-8")
            return base64_string

    @keyword("Initialize VRT")
    def initialize_vrt(self, api_url, api_key, project, ci_build_id, branch_name, enable_soft_assert, default_tolerance_level, browser, device, viewport):
        """Initialize VRT library.
        \n:param api_url: (str) The URL where the VRT API is installed.
        \n:param api_key: (str) The API key assigned for your VRT can be found inside the profile page in VRT frontend.
        \n:param project: (str) The project key or name for your existing project in VRT. The project key can be found after you create the project.
        \n:param ci_build_id: (str) The name will be given to VRT project build id. The build name will help you track where the baseline and test variation images are stored.
        \n:param branch_name: (str) The branch name you have provided when you created your project in VRT. The branch name can be found in VRT projects list.
        \n:param enable_soft_assert: (str) The value should be true or false, if the value is false it will log the errors instead of exceptions.
        \ndefault_tolerance_level: (str) Set default tolerance level, the value will be use if the diff_tolerance_level is set to None.
        \n:param browser: (str) The browser name you will use to execute the scripts. Included in test variations inputs.
        \n:param device: (str) The device name you will use to execute the scripts. Included in test variations inputs.
        \n:param viewport: (str) The viewport size of the browser. Included in test variations inputs.
        """
        self.config = Config(
            apiUrl = api_url,
            ciBuildId = ci_build_id,
            branchName = branch_name,
            project = project,
            apiKey = api_key,
            enableSoftAssert = enable_soft_assert
        )
        self.vrt = VisualRegressionTracker(self.config)
        self.default_tolerance_level = default_tolerance_level
        self.browser = browser
        self.device = device
        self.viewport = viewport

    @keyword("Verify Track Image")
    def verify_track_image(self, name, locator=None, diff_tolerance_level=None):
        """Track the target locator or page.
        \n:param name: (str) The name you will provide for the baseline and later on will be use in test run as well. Included in test variations inputs.
        \n:param locator: (str) The locator of an element to screenshot with. Any locator type is acceptable.
        \n:param diff_tolerance_level: (str) The threshold value for accepting the test run result. The value should be in float/decimal format (eg. 5.0).
        \nWhen there is no value 
        \nEx:
        \n1. With "name" param only.
        \n- Verify Track Image | Image1
        \nThis syntax will trigger the page screenshot and will use the default tolerance level from Initialize VRT method.
        \n2. With "name" and "locator" params
        \n- Verify Track Image | Image 1 | locator=xpath
        \nThis syntax will trigger the element screenshot and will use the default tolerance level from Initialize VRT method.
        \n3. With "name" and "diff_tolerance_level" params
        \n- Verify Track Image | Image 1 | diff_tolerance_level=5.0
        \n- Verify Track Image | Image 1 | diff_tolerance_level=10.0
        \nThese syntax will trigger the page screenshot and will use the given difference tolerance level.
        \n4. With "name", "locator", and "diff_tolerance_level" params
        \n- Verify Track Image | Image 1 | locator=xpath | diff_tolerance_level=5.0
        \n- Verify Track Image | Image 1 | locator=css | diff_tolerance_level=10.0
        \nThese syntax will trigger the element screenshot and will use the given difference tolerance level.
        """
        selenium_instance = built_in.get_library_instance("SeleniumLibrary")
        if locator is None:
            image = selenium_instance.capture_page_screenshot()
            image_base64 = ImageComparisonLibrary.image_to_base64(image)
        else:
            image = selenium_instance.capture_element_screenshot(locator)
            image_base64 = ImageComparisonLibrary.image_to_base64(image)
        if diff_tolerance_level is None:
            diff_tolerance_level = self.default_tolerance_level
        with self.vrt:
            try:
                test_run_result = self.vrt.track(TestRun(
                    name = name,
                    imageBase64 = image_base64,
                    diffTollerancePercent = float(diff_tolerance_level),
                    browser = self.browser,
                    device = self.device,
                    viewport = self.viewport
                ))
                status = test_run_result.testRunResponse.status
                built_in.should_be_true(status == TestRunStatus.OK)
            except:
                built_in.fail("[Status: " + str(status) + "] " + "Image has no baseline or detected a difference." )