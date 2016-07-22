;;; 50-markup --- inits
;;; Commentary:

;;; Code:

;; HTML
(when (locate-library "web-mode")
  (add-to-list 'auto-mode-alist '("\\.\\(hbs\\|ftl\\|html\\)\\'" . web-mode)))

;;; 50-markup.el ends here
