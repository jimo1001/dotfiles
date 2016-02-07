;;; 80-theme --- inits
;;; Commentary:

;;; Code:
(if (functionp 'load-theme)
    ;; built-in (Since: 24.1)
    (when (load "~/.emacs.d/etc/themes/theme-jimo1001.el" t)
      (enable-theme 'jimo1001)))
;; powerline theme
(when (require 'powerline nil t)
  (powerline-default-theme))

;;; 80-theme.el ends here
