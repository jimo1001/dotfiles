;;; inits --- Mailer (Wanderlust)
;;; Commentary:

;;; Code:

(use-package wl
  :bind ("C-c m m" . wl)
  :init
  (setq elmo-imap4-use-cache t)
  (setq elmo-imap4-use-modified-utf7 t)
  (setq elmo-message-fetch-threshold 500000)
  (setq elmo-msgdb-convert-type 'auto)
  (setq elmo-network-session-retry-count t)
  (setq elmo-network-session-idle-timeout 1800)
  (setq mime-edit-split-message nil)
  (setq mime-save-directory "~/Downloads")
  (setq mime-setup-enable-inline-html nil)
  (setq mime-view-ignored-field-list '("^.*"))
  (setq signature-insert-at-eof t)
  (setq signature-separator "\n")
  (setq wl-auto-select-first t)
  (setq wl-auto-select-next 'unread)
  (setq wl-biff-check-folder-async t)
  (setq wl-biff-state-indicator-off "[-]")
  (setq wl-biff-state-indicator-on "[!]")
  (setq wl-biff-use-idle-timer t)
  (setq wl-demo nil)
  (setq wl-draft-reply-buffer-style 'keep)
  (setq wl-draft-reply-default-position 'bottom)
  (setq wl-draft-reply-use-address-with-full-name nil)
  (setq wl-expire-use-log t)
  (setq wl-fcc-force-as-read t)
  (setq wl-folder-check-async t)
  (setq wl-folder-hierarchy-access-folders '("^.*$"))
  (setq wl-folder-move-cur-folder t)
  (setq wl-icon-directory (locate-user-emacs-file "share/wl/icons"))
  (setq wl-message-id-use-message-from t)
  (setq wl-prefetch-threshold 500000)
  (setq wl-stay-folder-window t)
  (setq wl-summary-exit-next-move nil)
  (setq wl-summary-line-format "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")
  (setq wl-summary-max-thread-depth 30)
  (setq wl-summary-weekday-name-lang 'en)
  (setq wl-summary-width nil)
  (setq wl-thread-have-younger-brother-str "+")
  (setq wl-thread-horizontal-str "-")
  (setq wl-thread-indent-level 2)
  (setq wl-thread-insert-opened t)
  (setq wl-thread-space-str " ")
  (setq wl-thread-vertical-str "|")
  (setq wl-thread-youngest-child-str "+")
  (setq wl-init-file (locate-user-emacs-file ".wl"))
  (setq wl-folders-file (locate-user-emacs-file ".folders"))
  (setq wl-alias-file (locate-user-emacs-file ".im/aliases"))
  (setq wl-address-file (locate-user-emacs-file ".addresses"))
  (setq mail-signature-file (locate-user-emacs-file ".signature"))

  :config
  (setq wl-summary-line-format-spec-alist
        (append wl-summary-line-format-spec-alist
                '((?@ (wl-summary-line-attached)))))
  ;; Visible Headers
  (setq wl-message-visible-field-list
        (append mime-view-visible-field-list
                '("^Subject:" "^From:" "^To:" "^Cc:" "^Bcc:"
                  "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
                  "^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:")))

  ;; Invisible Headers
  (setq wl-message-ignored-field-list
        (append mime-view-ignored-field-list
                '(".*Received:" ".*Path:" ".*Id:" "^References:"
                  "^Replied:" "^Errors-To:"
                  "^Lines:" "^Sender:" ".*Host:" "^Xref:"
                  "^Content-Type:" "^Content-Transfer-Encoding:"
                  "^Precedence:"
                  "^Status:" "^X-VM-.*:"
                  "^X-Info:" "^X-PGP" "^X-Face-Version:"
                  "^X-UIDL:" "^X-Dispatcher:"
                  "^MIME-Version:" "^X-ML" "^Message-I.:"
                  "^Delivered-To:" "^Mailing-List:"
                  "^ML-Name:" "^Reply-To:" "Date:"
                  "^X-Loop" "^X-List-Help:"
                  "^X-Trace:" "^X-Complaints-To:"
                  "^Received-SPF:" "^Message-ID:"
                  "^MIME-Version:" "^Content-Transfer-Encoding:"
                  "^Authentication-Results:"
                  "^X-Priority:" "^X-MSMail-Priority:"
                  "^X-Mailer:" "^X-MimeOLE:")))

  ;; User-Agent
  (when (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
  (when (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))
  (defun wl-generate-user-agent-string-2 (&optional verbose)
    "Return custom User-Agent field value."
    (concat (product-string-1 'wl-version nil) " on "
            (wl-extended-emacs-version3 "/" nil)))
  (setq wl-generate-mailer-string-function
        'wl-generate-user-agent-string-2)

  ;; attached file
  (setq elmo-msgdb-extra-fields
        (cons "content-type" elmo-msgdb-extra-fields))
  ;; TLS
  (set-alist 'elmo-network-stream-type-alist "!" '(ssl tls open-tls-stream))
  ;; faces
  (custom-set-faces
   '(wl-highlight-folder-zero-face ((t (:foreground "#87afd7")))))

  (add-hook 'wl-folder-check-entity-hook
            #'(lambda ()
                (wl-folder-open-unread-folder entity))))

;;; 80-mailer.el ends here
