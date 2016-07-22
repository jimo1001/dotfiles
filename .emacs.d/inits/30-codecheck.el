;;; 30-codecheck --- init file
;;; Commentary:

;;; Code:

(when (require 'flycheck nil t)
  (add-hook 'after-init-hook #'global-flycheck-mode)
  ;; key bindings
  (define-key flycheck-mode-map (kbd "M-e") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "M-E") 'flycheck-previous-error))

;;; 30-codecheck.el ends here
