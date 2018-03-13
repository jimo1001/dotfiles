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

;; Hackers News - https://news.ycombinator.com
(use-package hackernews
  :defer t
  :config
  (custom-set-faces
   '(hackernews-link-face ((t (:foreground "#4277f4"))))
   '(hackernews-comment-count-face ((t (:foreground "#666699"))))))

;;; 60-tools.el ends here
