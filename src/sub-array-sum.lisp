(defpackage :sub-array-sum
  (:use cl)
  (:export sub-array-sum sub-array-pos-sum))

(in-package :sub-array-sum)

(defun array-sum (array from to)
  (reduce #'+ array :start from :end to :initial-value 0))

(defun sub-array-sum (array target)
  (let* ((size (length array))
	 (indices (loop :for x :below size :append (loop :for y :from (1+ x) :upto size :collect (cons x y)))))
    (find-if (lambda (idxs) (= target (array-sum array (car idxs) (cdr idxs)))) indices)))

(defun sub-array-sum-2 (array x y sum target)
  (cond ((= sum target) (cons x y))
	((and (< sum target) (< y (length array))) (sub-array-sum-2 array x (1+ y) (+ sum (aref array y)) target))
	((> sum target) (cond ((< (1+ x) y) (sub-array-sum-2 array (1+ x) y (- sum (aref array x)) target))
			      ((< (1+ x) (length array)) (sub-array-sum-2 array (1+ x) (+ 2 x) (aref array (1+ x)) target))))))

(defun sub-array-pos-sum (array target)
  (sub-array-sum-2 array 0 1 (aref array 0) target))
