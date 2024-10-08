from robot.api import ExecutionResult, ResultVisitor
from robot.reporting.resultwriter import ResultWriter
from robot.conf.settings import RebotSettings

class WarningRemover:
    ROBOT_LIBRARY_SCOPE = "GLOBAL"
    ROBOT_LISTENER_API_VERSION = 3

    @staticmethod
    def output_file(original_output_xml):
        result = ExecutionResult(original_output_xml)
        result.visit(MyResultVisitor())
        ResultWriter(result).write_results(RebotSettings(output=original_output_xml, log=None, report=None))

class MyResultVisitor(ResultVisitor):

    def start_errors(self, errors):
        errors.messages = [message for message in errors.messages if message.level != 'WARN']
        pass