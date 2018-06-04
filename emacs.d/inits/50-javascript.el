;;; inits --- JavaScript
;;; Commentary:

;;; Code:

;; js-mode
(use-package js-mode
  :defer t
  :init
  (setq js-mirror-mode nil
        js-bounce-indent-flag nil
        js-indent-level 2
        js-cleanup-whitespace t))

;; js2-mode
(use-package js2-mode
  :defer t
  :init
  (setq js2-mode-show-strict-warnings nil)
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config
  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))

  ;; disable warnings, use eslint
  (add-hook 'js2-jsx-mode-hook
            (lambda ()
              (auto-complete-mode t)))

  (custom-set-faces
   '(js2-function-call ((t (:inherit default :foreground "#6699ff"))))
   '(js2-object-property ((t (:foreground "#73c5ff"))))))


;; web-mode
(use-package web-mode
  :defer t
  :mode ("\\.js\\'" . web-mode)
  :init
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  :config
  (setq web-mode-attr-indent-offset nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-sql-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  ;; use eslint with web-mode for jsx files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (web-mode-set-content-type "jsx")
  (custom-set-faces
   '(web-mode-constant-face ((t (:foreground "#9999ff"))))
   '(web-mode-type-face ((t (:foreground "#ccccff"))))))

;;; 50-javascript.el ends here
