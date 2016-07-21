;;; 50-javascript --- inits
;;; Commentary:

;;; Code:

;; js-mode
(setq js-mirror-mode nil)
(setq js-bounce-indent-flag nil)
(setq js-indent-level 4)
(setq js-cleanup-whitespace nil)

;; js2-mode
(when (functionp 'js2-mode)
  (setq js2-mode-show-strict-warnings nil)
  ;;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  ;;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))
  (with-eval-after-load "js2-mode"
    ;; disable warnings, use eslint
    (add-hook 'js2-jsx-mode-hook
              '(lambda ()
                 (auto-complete-mode t)))))

;; web-mode
(when (functionp 'web-mode)
  ;; use eslint with web-mode for jsx files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  ;; indent
  (setq web-mode-attr-indent-offset nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-sql-indent-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

  (with-eval-after-load "web-mode"
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    (web-mode-set-content-type "jsx")))

;;; 50-javascript.el ends here
