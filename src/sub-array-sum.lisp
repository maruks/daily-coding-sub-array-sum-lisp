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

(defvar *target*)
(defvar *array*)
(defvar *array-size*)

(defun sub-array-sum-2 (start index sum)
  (when (<= index *array-size*)
    (cond ((= sum *target*) (cons start index))
	  ((and (> sum *target*) (< start (1- index))) (sub-array-sum-2 (1+ start) index (- sum (aref *array* start))))
	  ((< index *array-size*) (sub-array-sum-2 start (1+ index) (+ sum (aref *array* index)))))))

(defun sub-array-pos-sum (array target)
  (let ((*target* target)
	(*array* array)
	(*array-size* (length array)))
    (sub-array-sum-2 0 1 (aref array 0))))
