import python
import semmle.python.ApiGraphs

abstract class LoggingSinks extends DataFlow::Node { }

class PrintMethod extends LoggingSinks {
  PrintMethod() {
    exists(DataFlow::Node call |
      call = API::builtin("print").getACall() and
      call.getScope().inSource() and
      this = call
    )
  }
}

class LoggingFramework extends LoggingSinks {
  LoggingFramework() {
    exists(DataFlow::Node call, e() and
      this = call
    )
  }
}
