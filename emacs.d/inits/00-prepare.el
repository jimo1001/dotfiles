;;; inits --- Prepare Initialization
;;; Commentary:

;;; Code:

(defun elapsed-time ()
  "Return elapsed time of Emacs initiation."
  (float-time (time-subtract after-init-time before-init-time)))

(add-hook 'after-init-hook
          #'(lambda () (message "elapsed time: %.6f sec" (elapsed-time))))

(use-package auto-compile
  :config
  (add-hook 'emacs-lisp-mode-hook #'auto-compile-mode))

;;; 00-prepare.el ends here
