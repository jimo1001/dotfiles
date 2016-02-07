;;; 60-skk --- inits
;;; Commentary:

;;; Code:
(when (require 'skk nil t)
  ;; cursor color (hiragana)
  (setq skk-cursor-hiragana-color "#af5f5f")
  ;; charactor encoding
  (setq skk-jisyo-code 'euc-jp-unix)

  ;; Specify dictonary location
  (setq skk-large-jisyo "~/.emacs.d/share/skk/dict/SKK-JISYO.L")
  ;; From DDSKK 14.2:
  ;;   メイン辞書（L 辞書、CDB 形式辞書、辞書サーバ）以外の辞書を指定する
  (setq skk-extra-jisyo-file-list
        (list "~/.emacs.d/share/skk/dict/SKK-JISYO.JIS2"
              '("~/.emacs.d/share/skk/dict/SKK-JISYO.JIS3_4" . euc-jisx0213)
              "~/.emacs.d/share/skk/dict/SKK-JISYO.notes"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.assoc"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.edict"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.geo"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.hukugougo"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.jinmei"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.law"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.okinawa"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.propernoun"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.pubdic+"
              "~/.emacs.d/share/skk/dict/SKK-JISYO.station"
              "~/.emacs.d/share/skk/dict/zipcode/SKK-JISYO.zipcode"
              "~/.emacs.d/share/skk/dict/zipcode/SKK-JISYO.office.zipcode"))

  ;; Specify tutorial Location
  (setq skk-tut-file "~/.emacs.d/etc/skk/SKK.tut")
  ;; SKK の個人辞書
  (setq skk-jisyo "~/.emacs.d/tmp/.skk-jisyo")
  (setq skk-backup-jisyo "~/.emacs.d/tmp/.skk-jisyo.BAK")
  (setq skk-record-file "~/.emacs.d/tmp/.skk-record")
  ;; stickey shift
  (setq skk-sticky-key ";")
  ;; より洗練されたインライン候補表示
  (setq skk-show-inline 'vertical)
  (when skk-show-inline
    ;; 変数 skk-treat-candidate-appearance-function を利用して自前で候補に
    ;; 色を付ける場合はこの変数を nil に設定する。
    (setq skk-inline-show-face nil)
    (setq skk-inline-show-foreground-color "#e5e5e5")
    (setq skk-inline-show-background-color "#303030")
    (setq skk-inline-show-background-color-odd "#505050"))
  ;; 変換時，改行でも確定
  (setq skk-egg-like-newline t)
  ;; 句読点
  (setq skk-kuten-touten-alist
        '((jp . ("。" . "、" )) ;(jp . ("．" . "，"))
          (en . ("．" . "，"))))
  ;; jp にすると「。、」を使います
  (setq-default skk-kutouten-type 'jp)
  ;; "「"を入力したら"」"も自動で挿入
  (setq skk-auto-insert-paren t)
  ;; isearch時にSKKをオフ
  (setq skk-isearch-start-mode 'latin)
  ;; auto save (idle 10min)
  (defvar skk-auto-save-jisyo-interval 600)
  (defun skk-auto-save-jisyo ()
    (skk-save-jisyo))
  (run-with-idle-timer skk-auto-save-jisyo-interval
                       skk-auto-save-jisyo-interval
                       'skk-auto-save-jisyo)
  ;; keybind
  (global-set-key "\C-xj" 'skk-mode))

;;; 60-skk.el ends here
