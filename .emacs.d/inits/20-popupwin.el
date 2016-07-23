;;; popwin --- inits
;;; Commentary:

;;; Code:

;; popwin
;; https://github.com/m2ym/popwin-el
(load-library "popwin")
(popwin-mode 1)

(push '("*Buffer List*" :height 0.5) popwin:special-display-config)
(push '("*Compile-Log*" :noselect t) popwin:special-display-config)
(push '("*Table of Contents*" :noselect t) popwin:special-display-config)

;; M-!
(push "*Shell Command Output*" popwin:special-display-config)

;; M-x compile
(push '(compilation-mode :noselect t) popwin:special-display-config)

;; vc
(push "*vc-diff*" popwin:special-display-config)
(push "*vc-change-log*" popwin:special-display-config)

;;; 20-popupwin.el ends here
