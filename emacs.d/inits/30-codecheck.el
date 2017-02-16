;;; inits --- Code Syntax Check
;;; Commentary:

;;; Code:

(use-package flycheck
  :defer 2
  :bind (:map flycheck-mode-map
              (("M-e" . flycheck-next-error)
               ("M-E" . flycheck-previous-error)))
  :init
  (setq flycheck-mode-line-prefix "E/W")
  :config
  (custom-set-faces
   '(flycheck-error ((t (:underline "#af0000"))))
   '(flycheck-warning ((t (:underline "#afaf00")))))
  (global-flycheck-mode t))

;;; 30-codecheck.el ends here
