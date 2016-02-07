;;; popwin --- inits
;;; Commentary:

;;; Code:

;; https://github.com/m2ym/popwin-el
(when (require 'popwin nil t)
  (setq popwin:special-display-config
        (append '(("*Ido Completions*" :noselect t)
                  ("*Python Output*" :noselect t)
                  ("*Compile-Log*" :noselect t)
                  ("*Table of Contents*" :noselect t)) popwin:special-display-config))

  ;; dired
  (push '(dired-mode :position top) popwin:special-display-config)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq special-display-function 'popwin:special-display-popup-window))

;;; 20-popupwin.el ends here
