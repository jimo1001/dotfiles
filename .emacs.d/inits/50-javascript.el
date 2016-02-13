;;; 50-javascript --- inits
;;; Commentary:

;;; Code:

(when (featurep 'js)
  (setq js-mirror-mode nil)
  (setq js-bounce-indent-flag nil)
  (setq js-indent-level 4)
  (setq js-cleanup-whitespace nil))

(when (autoload-if-found 'js2-mode "js2-mode" "JavaScript-IDE, JSX-IDE" t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
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

;;; 50-javascript.el ends here
