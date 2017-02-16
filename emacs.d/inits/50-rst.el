;;; inits --- reStructuredText
;;; Commentary:

;;; Code:

(use-package rst
  :mode ("\\.\\(rst\\|rest\\)\\'" . rst-mode)
  :bind (:map rst-mode-map ("C-c . t" . rst-toc))
  :config
  (custom-set-faces
   '(rst-level-1-face ((t (:foreground "#afcdcd" :background "#080808" :weight bold))))
   '(rst-level-2-face ((t (:foreground "#87cdcd" :background "#080808" :weight bold))))
   '(rst-level-3-face ((t :foreground "#5faf5f" :background "#080808" :weight bold)))
   '(rst-level-4-face ((t :foreground "#5f5faf" :background "#080808")))
   '(rst-level-5-face ((t :background "5fcd5f" :background "#080808")))
   '(rst-level-6-face ((t :foreground "#00cdcd" :background "#080808")))))

;;; 50-rst.el ends here
