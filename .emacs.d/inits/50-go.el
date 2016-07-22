;;; 50-go --- inits
;;; Commentary:

;;; Code:
(when (locate-library "go-mode")
  ;; GOPATH
  (exec-path-from-shell-copy-env "GOPATH")
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

  (with-eval-after-load "go-mode"
    ;; auto-complete
    (when (locate-library "go-autocomplete")
      (load-library "go-autocomplete"))

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
