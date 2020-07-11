(defpackage :sub-array-sum
  (:use #:cl #:alexandria #:serapeum)
  (:export #:sub-seq-sum #:sub-array-sum #:sub-array-pos-sum #:sub-array-hash-sum))

(in-package #:sub-array-sum)

(defun sub-seq-sum (array from to)
  (reduce #'+ array :start from :end (1+ to) :initial-value 0))

;; O(n^2)
(defun sub-array-sum (array target)
  (let* ((size (length array))
	 (indices (loop :for x :below size
			:append (loop :for y :from x :upto (1- size) :collect (cons x y)))))
    (find-if (lambda (idxs) (= target (sub-seq-sum array (car idxs) (cdr idxs)))) indices)))

(defvar *target*)
(defvar *array*)
(defvar *array-size*)

(defun find-sub-array-pos-sum (start index sum)
  (when (<= index *array-size*)
    (cond ((= sum *target*) (cons start (1- index)))
	  ((and (> sum *target*) (< start (1- index))) (find-sub-array-pos-sum (1+ start) index (- sum (aref *array* start))))
	  ((< index *array-size*) (find-sub-array-pos-sum start (1+ index) (+ sum (aref *array* index)))))))

;; O(n)
;; works for non-negative numbers only
(defun sub-array-pos-sum (array target)
  (let ((*target* target)
	(*array* array)
	(*array-size* (length array)))
    (find-sub-array-pos-sum 0 1 (aref array 0))))

;; O(n)
;; calculate current sum s(i) for each index i
;; result is found if s(p) = target - current sum for any of previous indices p
;; index 0  1  2  3  4  5
;; elem  1  3  2  5  3  1
;; sum   1  4  6  11 14 15
;; sum (1 to 3) = s(3) - s(0) = 11 - 1 = 10

(defun find-sub-array-hash-sum (sum-idx-hash sum idx)
  (let* ((next-sum (+ sum (aref *array* idx)))
	 (i (gethash (- next-sum *target*) sum-idx-hash)))
    (cond (i
	   (cons (1+ i) idx))
	  ((< idx *array-size*)
	   (setf (gethash next-sum sum-idx-hash) idx)
	   (find-sub-array-hash-sum sum-idx-hash next-sum (1+ idx))))))

(defun sub-array-hash-sum (array target)
  (let ((*target* target)
	(*array* array)
	(*array-size* (length array)))
    (find-sub-array-hash-sum (dict 0 -1) 0 0)))
