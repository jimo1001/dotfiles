;;; 50-shell --- inits
;;; Commentary:

;;; Code:
(when (functionp 'eshell)
  (setq eshell-cmpl-ignore-case t)
  (setq eshell-ask-to-save-history (quote always))
  (setq eshell-cmpl-cycle-completions t)
  (setq eshell-cmpl-cycle-cutoff-length 5)
  (setq eshell-hist-ignoredups t)

  (with-eval-after-load "eshell"
    (setq eshell-prompt-function
          (lambda ()
            (concat (eshell/whoami) "@" hostname
                    " (" (eshell/basename (eshell/pwd)) ") "
                    (if (= (user-uid) 0) "# " "$ "))))
    (set-face-foreground 'eshell-prompt-face "green")
    (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
    (define-key eshell-mode-map (kbd "C-p") 'eshell-previous-matching-input-from-input)
    (define-key eshell-mode-map (kbd "C-n") 'eshell-next-matching-input-from-input)
    (define-key eshell-mode-map (kbd "C-c C-l") 'eshell/clear))
  (setq eshell-prompt-regexp "^[^#$]*[$#] ")
  ;; バッファをクリアする
  (defun eshell/clear ()
    "Clear the current buffer, leaving one prompt at the top."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer))))

;;; 50-shell.el ends here
