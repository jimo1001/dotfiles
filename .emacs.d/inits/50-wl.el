;; wanderlust
;; info: Mailer

;;; Code:
(when (autoload-if-found '(wl wl-other-frame) "wl" "Wanderlust" t)
  (eval-after-load "wl"
    '(progn
       ;; for elscreen
       (when (featurep 'elscreen)
         (require 'elscreen-wl nil t))
       (if (boundp 'mail-user-agent)
           (setq mail-user-agent 'wl-user-agent))
       (if (fboundp 'define-mail-user-agent)
           (define-mail-user-agent
             'wl-user-agent
             'wl-user-agent-compose
             'wl-draft-send
             'wl-draft-kill
             'mail-send-hook))))
  (global-set-key (kbd "C-c m m") 'wl))
(autoload-if-found '(wl-draft wl-user-agent-compose)
                   "wl-draft" "Write draft with Wanderlust." t)