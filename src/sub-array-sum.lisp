(defpackage :sub-array-sum
  (:use cl alexandria serapeum)
  (:export sub-array-sum sub-array-pos-sum sub-array-hash-sum))

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

(defun find-sub-array-pos-sum (start index sum)
  (when (<= index *array-size*)
    (cond ((= sum *target*) (cons start index))
	  ((and (> sum *target*) (< start (1- index))) (find-sub-array-pos-sum (1+ start) index (- sum (aref *array* start))))
	  ((< index *array-size*) (find-sub-array-pos-sum start (1+ index) (+ sum (aref *array* index)))))))

;; works for non-negative numbers only
(defun sub-array-pos-sum (array target)
  (let ((*target* target)
	(*array* array)
	(*array-size* (length array)))
    (find-sub-array-pos-sum 0 1 (aref array 0))))

(defun find-sub-array-hash-sum (idx-sum-hash sum idx)
  (let ((s (gethash (- sum *target*) idx-sum-hash)))
    (cond (s (cons (1+ s) idx))
	  ((< idx *array-size*) (let* ((next-sum (+ sum (aref *array* idx))))
				  (setf (gethash next-sum idx-sum-hash) idx)
				  (find-sub-array-hash-sum idx-sum-hash next-sum (1+ idx)))))))

(defun sub-array-hash-sum (array target)
  (let ((*target* target)
	(*array* array)
	(*array-size* (length array)))
    (find-sub-array-hash-sum (dict 0 -1) 0 0)))
