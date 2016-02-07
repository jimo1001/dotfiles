;;; 50-shell --- inits
;;; Commentary:

;;; Code:
(when (autoload-if-found 'eshell "eshell" nil t)
  ;; 補完時に大文字小文字を区別しない
  (setq eshell-cmpl-ignore-case t)
  ;; 確認なしでヒストリ保存
  (setq eshell-ask-to-save-history (quote always))
  ;; 補完時にサイクルする
  (setq eshell-cmpl-cycle-completions t)
  ;; 補完候補がこの数値以下だとサイクルせずに候補表示
  (setq eshell-cmpl-cycle-cutoff-length 5)
  ;; 履歴で重複を無視する
  (setq eshell-hist-ignoredups t)
  ;; プロンプトの設定
  (eval-after-load "eshell"
    '(progn
       (setq  eshell-prompt-function
              (lambda ()
                (concat (eshell/whoami) "@" hostname
                        " (" (eshell/basename (eshell/pwd)) ") "
                        (if (= (user-uid) 0) "# " "$ "))))
       (add-hook 'eshell-mode-hook
                 (lambda ()
                   (set-face-foreground 'eshell-prompt-face "green")
                   (define-key (current-local-map) "\C-a" 'eshell-bol)
                   (define-key (current-local-map) "\C-p" 'eshell-previous-matching-input-from-input)
                   (define-key (current-local-map) "\C-n" 'eshell-next-matching-input-from-input)
                   (define-key (current-local-map) "\C-c\C-l" 'eshell/clear)))))
  (setq eshell-prompt-regexp "^[^#$]*[$#] ")
  ;; バッファをクリアする
  (defun eshell/clear ()
    "Clear the current buffer, leaving one prompt at the top."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer))))

;;; 50-shell.el ends here
