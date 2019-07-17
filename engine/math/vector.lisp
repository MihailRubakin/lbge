(defpackage :lbge.math
  (:use :cl))

(in-package :lbge.math)

(defclass float2 ()
  ((x
    :initform 0
    :initarg :x
    :accessor x)
   (y
    :initform 0
    :initarg :y
    :accessor y)))

(defclass float3 ()
  ((x
    :initform 0
    :initarg :x
    :accessor x)
   (y
    :initform 0
    :initarg :y
    :accessor y)
   (z
    :initform 0
    :initarg :z
    :accessor z)))

(defclass float4 ()
  ((x
    :initform 0
    :initarg :x
    :accessor x)
   (y
    :initform 0
    :initarg :y
    :accessor y)
   (z
    :initform 0
    :initarg :z
    :accessor z)
   (w
    :initform 0
    :initarg :w
    :accessor w)))


(defgeneric add (vector1 vector2)
  (:documentation "Add two vector2 to vector1"))

(defgeneric sub (vector1 vector2)
  (:documentation "Subtract vector2 from vector1"))

(defgeneric mul (vector scalar)
  (:documentation "Multiply vector by a scalar"))

(defgeneric div (vector scalar)
  (:documentation "Divide vector by a scalar"))

(defgeneric dot (vector1 vector2)
  (:documentation "Dot product of vector1 and vector2"))

(defgeneric length (vector)
  (:documentation "The Euclidian norm of a vector"))

(defgeneric normalize (vector)
  (:documentation "Return a normalized vector"))

(defgeneric angle (vector1 vector2)
  (:documentation "Angle between two vectors in radians"))

(defgeneric negate (vector)
  (:documentation "Negate a vector"))

(defgeneric project (vector1 vector2)
  (:documentation "Projects vector1 onto vector2"))

(defgeneric eq (vector1 vector2)
  (:documentation "Test two vectors for equality"))

(defgeneric neq (vector1 vector2)
  (:documentation "Test two vectors for inequality"))


(defun make-float2 (x y)
  (make-instance 'float2 :x x :y y))

(defun make-float3 (x y z)
  (make-instance 'float3 :x x :y y :z z))

(defun make-float4 (x y z w)
  (make-instance 'float4 :x x :y y :z z :w w))


(defmethod add ((vector1 float2) vector2)
  (make-float2 (+ (x vector1) (x vector2))
	       (+ (y vector1) (y vector2))))

(defmethod add ((vector1 float3) vector2)
  (make-float3 (+ (x vector1) (x vector2))
	       (+ (y vector1) (y vector2))
	       (+ (z vector1) (z vector2))))

(defmethod add ((vector1 float4) vector2)
  (make-float4 (+ (x vector1) (x vector2))
	       (+ (y vector1) (y vector2))
	       (+ (z vector1) (z vector2))
	       (+ (w vector1) (w vector2))))


(defmethod sub ((vector1 float2) vector2)
  (make-float2 (- (x vector1) (x vector2))
	       (- (y vector1) (y vector2))))

(defmethod sub ((vector1 float3) vector2)
  (make-float3 (- (x vector1) (x vector2))
	       (- (y vector1) (y vector2))
	       (- (z vector1) (z vector2))))

(defmethod sub ((vector1 float4) vector2)
  (make-float4 (- (x vector1) (x vector2))
	       (- (y vector1) (y vector2))
	       (- (z vector1) (z vector2))
	       (- (w vector1) (w vector2))))


(defmethod mul ((vector float2) scalar)
  (make-float2 (* (x vector) scalar)
	       (* (y vector) scalar)))

(defmethod mul ((vector float3) scalar)
  (make-float3 (* (x vector) scalar)
	       (* (y vector) scalar)
	       (* (z vector) scalar)))

(defmethod mul ((vector float4) scalar)
  (make-float4 (* (x vector) scalar)
	       (* (y vector) scalar)
	       (* (z vector) scalar)
	       (* (w vector) scalar)))


(defmethod div ((vector float2) scalar)
  (make-float2 (/ (x vector) scalar)
	       (/ (y vector) scalar)))

(defmethod div ((vector float3) scalar)
  (make-float3 (/ (x vector) scalar)
	       (/ (y vector) scalar)
	       (/ (z vector) scalar)))

(defmethod div ((vector float4) scalar)
  (make-float4 (/ (x vector) scalar)
	       (/ (y vector) scalar)
	       (/ (z vector) scalar)
	       (/ (w vector) scalar)))


(defmethod dot ((vector1 float2) vector2)
  (+ (* (x vector1) (x vector2))
     (* (y vector1) (y vector2))))

(defmethod dot ((vector1 float3) vector2)
  (+ (* (x vector1) (x vector2))
     (* (y vector1) (y vector2))
     (* (z vector1) (z vector2))))

(defmethod dot ((vector1 float4) vector2)
  (+ (* (x vector1) (x vector2))
     (* (y vector1) (y vector2))
     (* (z vector1) (z vector2))
     (* (w vector1) (w vector2))))


(defmethod length ((vector float2))
  (sqrt (+ (expt (x vector) 2)
	   (expt (y vector) 2))))
  
(defmethod length ((vector float3))
  (sqrt (+ (expt (x vector) 2)
	   (expt (y vector) 2)
	   (expt (z vector) 2))))
  
(defmethod length ((vector float4))
  (sqrt (+ (expt (x vector) 2)
	   (expt (y vector) 2)
	   (expt (z vector) 2)
	   (expt (w vector) 2))))


(defmethod eq ((vector1 float2) vector2)
  (and (= (x vector1) (x vector2))
       (= (y vector1) (y vector2))))

(defmethod eq ((vector1 float3) vector2)
  (and (= (x vector1) (x vector2))
       (= (y vector1) (y vector2))
       (= (z vector1) (z vector2))))

(defmethod eq ((vector1 float2) vector2)
  (and (= (x vector1) (x vector2))
       (= (y vector1) (y vector2))
       (= (z vector1) (z vector2))
       (= (w vector1) (w vector2))))


(defun cross (vector1 vector2)
  (make-float3 (- (* (y vector1) (z vector2))
		  (* (z vector1) (y vector2)))
	       (- (* (z vector1) (x vector2))
		  (* (x vector1) (z vector2)))
	       (- (* (x vector1) (y vector2))
		  (* (y vector1) (x vector2))))) 


(defmethod normalize (vector)
  (div vector (length vector)))


(defmethod angle (vector1 vector2)
  (acos (/ (dot vector1 vector 2)
	   (* (length vector1)
	      (length vector2)))))


(defmethod project (vector1 vector2)
  (dot vector1 (normalize vector2)))


(defvar +float2-zero+ (make-instance 'float2))
(defvar +float3-zero+ (make-instance 'float3))
(defvar +float4-zero+ (make-instance 'float4))

(defvar +float2-one+ (make-instance 'float2 :x 1 :y 1))
(defvar +float3-one+ (make-instance 'float3 :x 1 :y 1 :z 1))
(defvar +float4-one+ (make-instance 'float4 :x 1 :y 1 :z 1 :w 1))

(defvar +float2-x+ (make-instance 'float2 :x 1))
(defvar +float2-y+ (make-instance 'float2 :y 1))

(defvar +float3-x+ (make-instance 'float3 :x 1))
(defvar +float3-y+ (make-instance 'float3 :y 1))
(defvar +float3-z+ (make-instance 'float3 :z 1))

(defvar +float4-x+ (make-instance 'float4 :x 1))
(defvar +float4-y+ (make-instance 'float4 :y 1))
(defvar +float4-z+ (make-instance 'float4 :z 1))
(defvar +float4-w+ (make-instance 'float4 :w 1))
