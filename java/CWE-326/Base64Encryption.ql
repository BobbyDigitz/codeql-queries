/**
 * @name Base64 Encoding of Sensitive Information
 * @description Base64 Encoding is not an encryption algorithum and should not be used to encryption Sensitive Information
 * @kind path-problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision high
 * @sub-severity high
 * @id java/weak-encryption
 * @tags security
 *       external/cwe/cwe-327
 */

import java
import semmle.code.java.dataflow.DataFlow
import semmle.code.java.dataflow.FlowSources
import semmle.code.java.dataflow.TaintTracking2
import DataFlow::PathGraph
// Internal
import github.Encoding
import github.SensitiveInformation

class Base64EncryptionConfig extends TaintTracking::Configuration {
  Base64EncryptionConfig() { this = "Base64EncryptionConfig" }

  override predicate isSource(DataFlow::Node source) {
    source instanceof SensitiveInformationSources
  }

  override predicate isSink(DataFlow::Node sink) { sink instanceof Base64::Encoding }
}

// ========== Query ==========
from DataFlow::PathNode source, DataFlow::PathNode sink, Base64EncryptionConfig config
where config.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "Sensative data is being logged $@.", source.getNode(),
  "user-provided value"
