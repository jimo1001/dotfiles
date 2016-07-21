;;; 50-wl --- inits
;;; Commentary:

;;; Code:
(when (functionp 'wl)
  (global-set-key (kbd "C-c m m") 'wl)
  (with-eval-after-load "wl"
    ;; for elscreen
    (when (featurep 'elscreen)
      (autoload-do-load 'elscreen-wl)
      (when (boundp 'mail-user-agent)
        (setq mail-user-agent 'wl-user-agent))
      (when (fboundp 'define-mail-user-agent)
        (define-mail-user-agent
          'wl-user-agent
          'wl-user-agent-compose
          'wl-draft-send
          'wl-draft-kill
          'mail-send-hook)))))

;;; 50-wl.el ends here
