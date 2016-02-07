;;; 50-javascript --- inits
;;; Commentary:

;;; Code:

;; JavaScript
(when (autoload-if-found 'js2-mode "js2-mode" "major mode for JavaScript" t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
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
       (setq js-cleanup-whitespace nil
             ;; disable warnings, use eslint
             js2-mode-show-strict-warnings nil
             js-mirror-mode nil
             js-bounce-indent-flag nil
             js-indent-level 4))))

;;; 50-javascript.el ends here
