;;; 25-helm --- inits
;;; Commentary:

;;; Code:

(helm-mode 1)

;; key bindings
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "C-c h")   'helm-mini)
(define-key global-map (kbd "C-c o")   'helm-occur)
(define-key global-map (kbd "C-c y")   'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "C-c C-b") 'helm-bookmarks)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; default sources
(setq helm-mini-default-sources
      '(helm-source-elscreen-list
        helm-source-buffers-list
        helm-source-bookmarks
        helm-source-file-cache
        helm-source-recentf
        helm-source-buffer-not-found))

(when (locate-library "helm-descbinds")
  (helm-descbinds-mode)
  (global-set-key (kbd "C-c b") 'helm-descbinds))

;; Disable helm in some functions
(add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

(defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
  "Transform the pattern to reflect my intention"
  (let* ((pattern (ad-get-arg 0))
         (input-pattern (file-name-nondirectory pattern))
         (dirname (file-name-directory pattern)))
    (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
    (setq ad-return-value
          (concat dirname
                  (if (string-match "^\\^" input-pattern)
                      ;; '^' is a pattern for basename
                      ;; and not required because the directory name is prepended
                      (substring input-pattern 1)
                    (concat ".*" input-pattern))))))

;; http://rubikitch.com/2014/12/19/helm-migemo/
(when (and (locate-library "helm-migemo") (locate-library "migemo"))
  (with-eval-after-load "migemo"
    (helm-migemo-mode)))

;; kill-buffer
(add-hook 'helm-kill-buffer-hook
          '(lambda ()
             (set-buffer "*scratch*")))

;;; 25-helm.el ends here
