(defsystem "sub-array-sum"
  :name "sub-array-sum"
  :version "0.0.1"
  :author "Maris Orbidans"
  :licence "Public Domain"
  :depends-on (:alexandria
	       :serapeum)
  :serial t
  :components ((:module "src"
		:serial t
		:components ((:file "sub-array-sum"))))
  :in-order-to ((test-op (test-op "sub-array-sum/tests"))))

(defsystem "sub-array-sum/tests"
  :licence "Public Domain"
  :depends-on (:sub-array-sum
	       :check-it
	       :fiasco)
  :serial t
  :components ((:module "tests"
		:components ((:file "sub-array-sum-tests"))))
  :perform (test-op (o c) (symbol-call 'fiasco 'all-tests)))
