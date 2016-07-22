;;; 99-post-init --- inits
;;; Commentary:

;;; Code:

;; elapsed time
(add-hook 'after-init-hook
          (lambda ()
            (message "Elapsed time: %.5f sec"
                     (float-time (time-subtract after-init-time before-init-time)))))


;;; 99-post-init.el ends here
