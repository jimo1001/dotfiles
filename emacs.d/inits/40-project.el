;;; inits --- Project Manager
;;; Commentary:

;;; Code:

(use-package projectile
  :defer t
  :init
  (setq projectile-projects-cache t
        projectile-file-exists-cache-timer t
        projectile-file-exists-local-cache-expire 3600
        projectile-mode-line-prefix " P")
  :config
  (projectile-mode t))

;;; 40-project.el ends here
