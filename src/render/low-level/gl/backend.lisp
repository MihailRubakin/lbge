(in-package :lbge.render.gl)

(defclass gl-backend (b:backend)
  ((context :documentation "GL context" :initform nil)
   (window :documentation "SDL window" :initform nil)))

(defmethod b:init ((backend gl-backend) window &optional info)
  "Init GL backend.
info is an alist, which may contain following keys:
:gl-version - a cons pair of maj . min context version"
  (with-slots (context (win window)) backend
    (assert (null context) nil
            "Context already initialized for renderer")
    (sb-int:with-float-traps-masked (:invalid)
      (let ((version (cadr (assoc :gl-version info))))
        (when version
          (sdl2:gl-set-attr :context-major-version (car version))
          (sdl2:gl-set-attr :context-minor-version (cdr version))
          (sdl2:gl-set-attr sdl2-ffi:+sdl-gl-context-profile-mask+
                            sdl2-ffi:+sdl-gl-context-profile-core+)))
      (setf context (sdl2:gl-create-context window)))
    (setf win window)))

(defmethod b:clear ((backend gl-backend))
  (gl:clear))

(defmethod b:render ((backend gl-backend) renderer))

(defmethod b:make-shader ((backend gl-backend))
  (let ((shader (make-instance 'gl-shader)))
    (setf (slot-value shader 'handle)
          (gl:create-program))
    shader))

(defmethod b:present ((backend gl-backend))
  (sb-int:with-float-traps-masked (:invalid)
    (sdl2:gl-swap-window (slot-value backend 'window))))

(defmethod b:deinit ((backend gl-backend))
  (sdl2:gl-delete-context (slot-value backend 'context)))