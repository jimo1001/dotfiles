;;; 50-go --- inits
;;; Commentary:

;;; Code:
(when (functionp 'go-mode)
  ;; GOPATH
  (exec-path-from-shell-copy-env "GOPATH")
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

  ;; auto-complete
  (require 'go-autocomplete)

  (with-eval-after-load "go-mode"
    (add-hook 'before-save-hook 'gofmt-before-save)
    ;; go-def
    (define-key go-mode-map (kbd "M-.") 'godef-jump)
    ;; go-rename
    (when (require 'go-rename nil t)
      (define-key go-mode-map (kbd "C-c r") 'go-rename))
    ;; go-eldoc
    (when (require 'go-eldoc nil t)
      (add-hook 'go-mode-hook 'go-eldoc-setup))))

;;; 50-go.el ends here
