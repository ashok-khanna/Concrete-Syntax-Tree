(cl:in-package #:concrete-syntax-tree)

(defclass parser ()
  ((%client :initarg :client :reader client)
   (%lambda-list :initarg :lambda-list :reader lambda-list)
   (%grammar :initarg :grammar :reader grammar)
   (%all-states :initarg :states :reader all-states)
   (%all-input :initarg :input :reader all-input)
   (%remaining-states :initarg :states :accessor remaining-states)
   (%remaining-input :initarg :input :accessor remaining-input)))

(defmethod initialize-instance :after ((object parser) &key rules)
  (let* ((states (loop repeat (1+ (length (all-input object)))
                       collect (make-instance 'earley-state)))
         (grammar (make-instance 'grammar :rules rules))
         (target-rule (find 'target (rules grammar) :key #'left-hand-side))
         (item (make-instance 'earley-item
                 :parse-trees '()
                 :origin (car states)
                 :dot-position 0
                 :rule target-rule)))
    (push item (items (car states)))
    (reinitialize-instance
     object
     :states states
     :grammar grammar)))