;;; inits --- Environment Settings
;;; Commentary:

;;; Code:

;; not display error message
(setq debug-on-error nil)

;; カーソルが遅くなる問題の対処 (emacs-24)
(setq-default bidi-display-reordering nil)

;;; Set Environment Variables

(use-package exec-path-from-shell
  :if window-system
  :init
  (setq exec-path-from-shell-check-startup-files nil
        exec-path-from-shell-arguments '("-l"))
  :config
  (exec-path-from-shell-copy-envs '("PATH" "GOROOT" "GOPATH" "WORKON_HOME" "HTTP_PROXY" "HTTPS_PROXY")))

(use-package async
  :defer t
  :config
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1))

;;; 05-env.el ends here
