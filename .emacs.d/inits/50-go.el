;;; 50-go --- inits
;;; Commentary:

;;; Code:
(when (autoload-if-found 'go-mode "go-mode" "GO mode" t)
  ;; GOPATH
  (exec-path-from-shell-copy-env "GOPATH")
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  (eval-after-load "go-mode"
    '(progn
       (add-hook 'before-save-hook 'gofmt-before-save)
       (add-hook 'go-mode-hook (lambda ()
                                 (local-set-key (kbd "M-.") 'godef-jump)))
       (when (require 'go-eldoc nil t)
         (add-hook 'go-mode-hook 'go-eldoc-setup)))))

;;; 50-go.el ends here
