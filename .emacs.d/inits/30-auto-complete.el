;;; 30-auto-complete --- inits
;;; Commentary:

;;; Code:

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/etc/auto-complete/dict")
  (setq ac-comphist-file "~/.emacs.d/tmp/ac-comphist.dat")

  (ac-config-default)

  (setq ac-use-menu-map t)
  ;; n文字以上の単語の時に補完を開始
  (setq ac-auto-start 2)
  ;; n秒後に補完開始
  (setq ac-delay 0.05)
  ;; 曖昧マッチ有効
  (setq ac-use-fuzzy t)
  ;; 補完推測機能有効
  (setq ac-use-comphist t)
  ;; n秒後に補完メニューを表示
  (setq ac-auto-show-menu 0.5)
  ;; n秒後にクイックヘルプを表示
  (setq ac-quick-help-delay 1.0)
  ;; 大文字・小文字を区別する
  (setq ac-ignore-case 'smart)

  ;; key bindings
  (define-key ac-complete-mode-map (kbd "TAB") 'ac-expand)
  (define-key ac-complete-mode-map (kbd "M-TAB") 'ac-complete)
  (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
  (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
  (define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch))

;;; 30-auto-complete.el ends here
