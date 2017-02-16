;;; inits --- Other Tools Settings
;;; Commentary:

;;; Code:

;; edit remote file
(use-package tramp
  :no-require t
  :defer t
  :init
  (setq tramp-default-method "ssh"))

;; diff
(use-package ediff
  :no-require t
  :defer t
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;; dired
(use-package dired+
  :init
  (setq diredp-hide-details-initially-flag nil)
  :config
  (custom-set-faces
   '(diredp-date-time ((t (:foreground "#a8a8a8"))))
   '(diredp-dir-heading ((t (:background "#303030" :foreground "#ffa500"))))
   '(diredp-dir-name ((t (:foreground "#5cacee"))))
   '(diredp-dir-priv ((t (:background "#2c2c2c" :foreground "#5cacee"))))
   '(diredp-file-name ((t (:foreground "#f0f0f0"))))
   '(diredp-file-suffix ((t (:foreground "#a8a8a8"))))
   '(diredp-link-priv ((t (:foreground "#87ceff"))))
   '(diredp-number ((t (:foreground "#f0f0f0"))))
   '(diredp-symlink ((t (:foreground "#b0e2ff")))))
  (diredp-toggle-find-file-reuse-dir 1))

(use-package hackernews
  :defer t
  :config
  (custom-set-faces
   '(hackernews-link-face ((t (:foreground "#4277f4"))))
   '(hackernews-comment-count-face ((t (:foreground "#666699"))))))

;;; 60-tools.el ends here
