;;; 40-elescreen --- inits
;;; Commentary:

;;; Code:

(when (require 'elscreen nil t)
  (elscreen-start)
  ;; hide [X]
  (setq elscreen-tab-display-kill-screen nil)
  ;; hide [ <-> ]
  (setq elscreen-tab-display-control nil)
  ;; tab width
  (setq elscreen-display-tab 24))

;;; 40-elscreen.el ends here
