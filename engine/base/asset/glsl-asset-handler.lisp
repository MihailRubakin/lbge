(in-package :lbge.asset)

(defclass glsl-asset-handler (asset-handler)
  ())

(defmethod handler-get-asset ((handler glsl-asset-handler) asset-manager key)
  (assert (eq (slot-value key 'asset-type) :glsl-source) nil)
  (let ((asset (make-instance 'asset))
        (file-path (find-asset-file-by-path
                    (asset-roots asset-manager)
                    (slot-value key 'path))))
    (if file-path
      (let ((shader-lines nil))
        (with-open-file (shader-file
                         source
                         :direction :input
                         :if-does-not-exist :error)
          (do ((line (read-line shader-file nil)
                     (read-line shader-file nil)))
              ((null line))
            (setf shader-lines (cons (format nil "~a~%" line)
                                     shader-lines))))
        (reverse shader-lines))

      (setf (asset-data asset) (format nil "File ~S not found" (slot-value key 'path))
            (asset-state asset) :error))
    asset))