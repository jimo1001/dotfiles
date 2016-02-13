;;; 80-theme --- inits
;;; Commentary:

;;; Code:
(if (functionp 'load-theme)
    ;; built-in (Since: 24.1)
    (when (load "~/.emacs.d/themes/theme-darcula.el" t)
      (enable-theme 'darcula)))
;; powerline theme
(when (require 'powerline nil t)
  (powerline-default-theme))

;;; 80-theme.el ends here
