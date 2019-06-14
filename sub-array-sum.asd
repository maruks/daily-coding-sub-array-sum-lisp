;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(defpackage #:sub-array-sum-asd
  (:use :cl :asdf))

(in-package :sub-array-sum-asd)

(asdf:defsystem "sub-array-sum"
  :name "sub-array-sum"
  :version "0.0.1"
  :author "Maris Orbidans"
  :licence "Public Domain"
  :serial t
  :components ((:module "src"
		:serial t
		:components ((:file "sub-array-sum"))))
  :in-order-to ((test-op (test-op "sub-array-sum/tests"))))

(asdf:defsystem "sub-array-sum/tests"
  :licence "Public Domain"
  :depends-on (:sub-array-sum
	       :check-it
	       :fiasco)
  :serial t
  :components ((:module "tests"
		:components ((:file "sub-array-sum-tests"))))
  :perform (test-op (o c) (uiop:symbol-call 'fiasco 'all-tests)))
