private import python

// ========== Sources ==========
module LocalSources {
  private import semmle.python.dataflow.new.DataFlow
  private import semmle.python.dataflow.new.TaintTracking
  private import semmle.python.Concepts
  private import semmle.python.dataflow.new.BarrierGuards
  private import semmle.python.ApiGraphs
  private import DataFlow::PathGraph

  abstract class Range extends DataFlow::Node { }

  // Standard Input from user
  class STDInputSources extends LocalSources::Range {
    STDInputSources() {
      exists(DataFlow::Node call |
        (
          // v = input("Input?")
          call = API::builtin("input").getACall()
          or
          // https://docs.python.org/3/library/fileinput.html
          call = API::moduleImport("fileinput").getMember("input").getACall()
        ) and
        call.getScope().inSource() and
        this = call
      )
    }
  }

  // Command Line Arguments
  class CommandLineArgumentsSources extends LocalSources::Range {
    CommandLineArgumentsSources() {
      exists(DataFlow::Node call |
        (
          // v = sys.args[1]
          call = API::moduleImport("sys").getMember("argv").getAValueReachableFromSource()
          or
          // parser = argparse.ArgumentParser(__name__)
          // ...
          // arguments = parser.parse_args()
          // v = arguments.t     # user input
          exists(DataFlow::CallCfgNode args |
            args =
              API::moduleImport("argparse")
                  .getMember("ArgumentParser")
                  .getACall()
                  .getAMethodCall("parse_args")
          |
            call = args
            or
            call = args.getAnAttributeRead()
          )
        ) and
        l#open
          // var = open('abc.txt')
          call = API::builtin("open").getACall().getAMethodCall("read")
          or
          // https://docs.python.org/3/library/os.html#os.read
          call = API::moduleImport("os").getMember(["read"]).getACall()
        ) and
        
  }
}
