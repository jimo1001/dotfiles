;;; cocoa-emacs-env --- inits
;;; Commentary:

;;; Code:
(setq hostname (shell-command-to-string "echo -n `hostname`"))

;; sync clipboard with osx
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)

;; dired
(let ((gls "/usr/local/bin/gls"))
  (if (file-exists-p gls) (setq insert-directory-program gls)))

;; C/Migemo
(when (locate-library "migemo")
  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-coding-system 'utf-8-unix))

;; for GUI
(when (window-system)
  ;; font - Ricty
  (set-face-attribute 'default nil
                      :family "Ricty Discord"
                      :height 120)
  (set-fontset-font nil
                    'japanese-jisx0208
                    (font-spec :family "Ricty Discord"))
  ;; Bell
  (setq ring-bell-function nil))

;;; cocoa-emacs-env.el ends here
