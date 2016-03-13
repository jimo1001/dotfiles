;;; 50-javascript --- inits
;;; Commentary:

;;; Code:

;; js-mode
(when (featurep 'js)
  (setq js-mirror-mode nil)
  (setq js-bounce-indent-flag nil)
  (setq js-indent-level 4)
  (setq js-cleanup-whitespace nil))

;; js2-mode
(when (autoload-if-found 'js2-mode "js2-mode" "JavaScript-IDE, JSX-IDE" t)
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
  (eval-after-load "js2-mode"
    '(progn
       ;; disable warnings, use eslint
       (setq js2-mode-show-strict-warnings nil)
       (add-hook 'js2-jsx-mode-hook
                 '(lambda ()
                    (auto-complete-mode t))))))

;; web-mode
(when (autoload-if-found 'web-mode "web-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (with-eval-after-load 'web-mode
    ;; use eslint with web-mode for jsx files
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(javascript-jshint)))
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    ;; disable json-jsonlist checking for json files
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(json-jsonlist)))
    ;; indent
    (add-hook 'web-mode-hook
              (progn
                (setq web-mode-attr-indent-offset nil)
                (setq web-mode-markup-indent-offset 2)
                (setq web-mode-css-indent-offset 2)
                (setq web-mode-sql-indent-offset 2)
                (setq indent-tabs-mode nil)
                (setq tab-width 2)
                (setq web-mode-code-indent-offset 4)
                (web-mode-set-content-type "jsx")))

    (setq web-mode-content-types-alist
          '(("jsx" . "\\.js[x]?\\'")))))

;;; 50-javascript.el ends here
