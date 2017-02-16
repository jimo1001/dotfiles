;;; inits --- Project Manager
;;; Commentary:

;;; Code:

(use-package projectile
  :defer t
  :init
  (setq projectile-projects-cache t
        projectile-file-exists-cache-timer t
        projectile-file-exists-local-cache-expire 3600)
  (setq projectile-mode-line
        '(:eval
          (when (not (file-remote-p default-directory))
            (format " P[%s]"
                    (projectile-project-name)))))
  :config
  (projectile-mode t))

;;; 40-project.el ends here
