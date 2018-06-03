(cl:in-package #:concrete-syntax-tree)

(defmethod acclimation:report-condition
    ((condition null-cst-required) stream (language acclimation:english))
  (format stream "~@<Encountered ~S where a CST satisfying ~A is ~
                  required.~@:>"
          (cst condition) 'null))

(defmethod acclimation:report-condition
    ((condition cons-cst-required) stream (language acclimation:english))
  (format stream "~@<Encountered ~S where a ~A is required.~@:>"
          (cst condition) 'cons-cst))
