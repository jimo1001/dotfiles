;;; inits --- Mailer (Wanderlust)
;;; Commentary:

;;; Code:

(use-package wl
  :bind ("C-c m m" . wl)
  :init
  ;; Basic
  (setq elmo-imap4-use-cache t
        elmo-imap4-use-modified-utf7 t
        elmo-message-fetch-threshold 500000
        elmo-msgdb-convert-type 'auto
        mime-edit-split-message nil
        mime-save-directory "~/Downloads"
        mime-setup-enable-inline-html nil
        mime-view-ignored-field-list '("^.*")
        signature-insert-at-eof t
        signature-separator "\n"
        wl-auto-select-first t
        wl-auto-select-next 'unread
        wl-biff-check-folder-async t
        wl-biff-state-indicator-off "[-]"
        wl-biff-state-indicator-on "[!]"
        wl-biff-use-idle-timer t
        wl-demo nil
        wl-draft-reply-buffer-style 'keep
        wl-draft-reply-default-position 'bottom
        wl-draft-reply-use-address-with-full-name nil
        wl-expire-use-log t
        wl-fcc-force-as-read t
        wl-folder-check-async t
        wl-folder-hierarchy-access-folders '("^.*$")
        wl-folder-move-cur-folder t
        wl-icon-directory "~/.emacs.d/share/wl/icons"
        wl-message-id-use-message-from t
        wl-prefetch-threshold 500000
        wl-stay-folder-window t
        wl-summary-exit-next-move nil
        wl-summary-line-format "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s"
        wl-summary-max-thread-depth 30
        wl-summary-weekday-name-lang 'en
        wl-summary-width nil
        wl-thread-have-younger-brother-str "+"
        wl-thread-horizontal-str "-"
        wl-thread-indent-level 2
        wl-thread-insert-opened t
        wl-thread-space-str " "
        wl-thread-vertical-str "|"
        wl-thread-youngest-child-str "+")

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
