/**
 * @name Code injection
 * @description Interpreting unsanitized user input as code allows a malicious user to perform arbitrary
 *              code execution.
 * @kind problem
 * @problem.severity warning
 * @security-severity 2.5
 * @sub-severity low
 * @precision very-low
 * @id py/code-injection-static
 * @tags security
 *       external/cwe/cwe-094
 *       external/cwe/cwe-095
 *       external/cwe/cwe-116
 *       external/owasp/owasp-a1
 *       experimental
 *       static
 */

import python
import semmle.python.Concepts
import semmle.python.ApiGraphs
private import semmle.python.security.dataflow.CodeInjectionCustomizations

from DataFlow::Node sink
where sink instanceof CodeInjection::Sink
select sink, "Usage of Code Execution function"
