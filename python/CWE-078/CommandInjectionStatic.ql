/**
 * @name Uncontrolled command line
 * @description Using externally controlled strings in a command line may allow a malicious
 *              user to change the meaning of the command.
 * @kind problem
 * @problem.severity warning
 * @security-severity 2.5
 * @sub-severity low
 * @precision very-low
 * @id py/command-line-injection-static
 * @tags security
 *       external/cwe/cwe-078
 *       external/cwe/cwe-088
 *       external/owasp/owasp-a1
 *       experimental
 *       static
 */

import python
import semmle.python.Concepts
import semmle.python.ApiGraphs
import semmle.python.dataflow.new.BarrierGuards

from DataFlow::Node sink
where
  sink = any(SystemCommandExecution e) and
  not sink.getScope().getEnclosingModule().getName() in ["os", "subprocess", "platform", "popen2"]
select sink, "Usage of command line"
