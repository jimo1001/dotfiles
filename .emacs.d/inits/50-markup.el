;;; 50-markup --- inits
;;; Commentary:

;;; Code:

;; HTML
(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.\\(hbs\\|ftl\\|html\\)\\'" . web-mode)))

;;; 50-markup.el ends here
