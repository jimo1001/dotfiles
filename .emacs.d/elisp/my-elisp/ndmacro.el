;;; ndmacro.l --- 連番機能付きdmacro
;;
;; $Id: ndmacro.l,v 1.1 2003/06/30 13:33:41 kia Exp $
;;
;; 増井俊之さんのdmacro.elにいわゆる連番の機能を持たせたものです。ndmacro.l
;; では数字列の部分における動作がオリジナルのdmacro.elとは異なります。
;; 
;; なお、元のdmacro.elはEmacs用ですが、このndmacro.lはxyzzy専用です。
;;
;;
;;; インストール
;;
;; ロードパスの中のいずれかの場所へ配置して、.xyzzyに次のように設定してください。
;; 割り当てるキーは必要に応じて変更してください。
;;
;;     (defconstant *ndmacro-key* #\C-t)
;;     (global-set-key *ndmacro-key* 'ndmacro-exec)
;;     (autoload 'ndmacro-exec "ndmacro" t)
;;
;;
;;; 連番機能
;;
;; 例えばユーザが
;;     100,101,
;; と入力した後「繰り返しキー」を押すと、ndmacro.l は 0から9の数字からなる
;; 文字列を数値として認識し、その数値の増減を行いながら入力操作を繰り返しま
;; す。その結果の文字列は
;;     100,101,102,
;; となります。数値を増加させるか減少させるか、そしてその量をどのくらいにす
;; るかはテキトーに予測します。
;;
;; ただし、数値を減少させる場合、減少させた結果が負値になるときはゼロが返さ
;; れます。すなわち一度ゼロになるとそれ以降は減少しません。
;;
;; 数値部分の最上位の位が一つ以上の`0'で埋められているときは、そのカラム数
;; に合わせて上位を`0'で埋めておきます。例えば
;;     abc001.txt
;;     abc002.txt
;; と入力したあと「繰り返しキー」を押すと、結果は
;;     abc001.txt
;;     abc002.txt
;;     abc003.txt
;; になります。
;;
;; 同時に複数の数値を増減できます。例えば、
;;     2x1=2
;;     2x2=4
;; と入力した後「繰り返しキー」を押すと、結果は
;;     2x1=2
;;     2x2=4
;;     2x3=6
;; になります。
;;
;;
;;; ndmacro.lに関する連絡先
;;
;; kia <kia@geocities.co.jp>
;; http://www.geocities.co.jp/SiliconValley-PaloAlto/5042/


;;; 以下の説明部分はオリジナルのdmacro.elのものです。

;;
;;      dmacro.el - キー操作の繰返し検出 & 実行
;;
;;	Version 2.0
;;
;;      1993 4/14        original idea by 増井俊之＠シャープ
;;                         implemented by 太和田誠＠長岡技科大
;;                          refinement by 増井俊之＠シャープ
;;	1995 3/30 modified for Emacs19 by 増井俊之＠シャープ
;;
;;	2002 3              XEmacs対応 by 小畑英司 obata@suzuki.kuee.kyoto-u.ac.jp
;;                                        峰伸行 zah07175@rose.zero.ad.jp
;;
;;

;;
;; dmacro.el は、繰り返されるキー操作列から次の操作を予測し実行させる
;; ためのプログラムです。操作の繰返しの検出とその実行を指令するために
;; *dmacro-key* で指定する特別の「繰返しキー」を使用します。
;;
;; 例えばユーザが
;;     abcabc
;; と入力した後「繰返しキー」を押すと、dmacro.el は "abc" の入力操作の
;; 繰返しを検出してそれを実行し、その結果テキストは
;;     abcabcabc
;; となります。また、
;;     abcdefab
;; と入力した後「繰返しキー」を押すと、dmacro.el はこれを "abcdef" の
;; 入力の繰返しと判断し、繰返しの残りの部分を予測実行して "cdef" を入力し、
;; テキストは
;;     abcdefabcdef
;; となります。ここでもう一度「繰返しキー」を押すと、"abcdef" の入力
;; が繰り返されて、テキストは
;;     abcdefabcdefabcdef
;; となります。
;;
;; あらゆるキー操作の繰返しが認識、実行されるため、例えば
;;     line1
;;     line2
;;     line3
;;     line4
;; というテキストを
;;     % line1
;;     % line2
;;     line3
;;     line4
;; のように編集した後「繰返しキー」を押すとテキストは
;;     % line1
;;     % line2
;;     % line3
;;     line4
;; のようになり、その後押すたびに次の行頭に "% "が追加されていきます。
;;
;; このような機能は、繰返しパタンの認識によりキーボードマクロを自動的に
;; 定義していると考えることもできます。キーボードマクロの場合は操作を
;; 開始する以前にそのことをユーザが認識してマクロを登録する必要があり
;; ますが、dmacro.el では実際に繰返し操作をしてしまった後でそのことに
;; 気がついた場合でも「繰返しキー」を押すだけでその操作をまた実行させる
;; ことができます。またマクロの定義方法(操作の後で「繰返しキー」を押す
;; だけ)もキーボードマクロの場合(マクロの開始と終了を指定する)に比べて
;; 単純になっています。
;;
;; ● 使用例
;;
;; ・文字列置換
;;
;; テキスト中の全ての「abc」を「def]に修正する場合を考えてみます。
;; 「abc」を検索するキー操作は "Ctrl-S a b c ESC" で、これは
;; "DEL DEL DEL d e f" で「def」に修正することができます。
;; 引き続き次の「abc」を検索する "Ctrl-S a b c ESC" を入力した後で
;; 「繰返しキー」を押すと "DEL DEL DEL d e f" が予測実行され、新たに
;; 検索された「abc」が「def」に修正されます。ここでまた「繰返しキー」
;; を押すと次の「abc」が「def」に修正されます。
;; このように「繰返しキー」を押していくことにより順々に文字列を
;; 置換していくことができます。
;;
;; ・罫線によるお絵書き
;;
;; 繰返しを含む絵を簡単に書くことができます。例えば、
;;   ─┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐┌┐
;;     └┘└┘└┘└┘└┘└┘└┘└┘└┘└┘└┘└┘└┘
;; のような絵を書きたい場合は、keisen.el などを使って
;;   ─┐┌┐
;;     └┘
;; と書いた後で「繰返し」キーを押すと、
;;   ─┐┌┐
;;     └┘└┘
;; となり、もう一度「繰返しキー」を押すと
;;   ─┐┌┐┌┐
;;     └┘└┘└┘
;; となります。同様に
;;  ┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐┌─┐
;;  └─┘└─┘└─┘└─┘└─┘└─┘└─┘└─┘
;; のような絵も
;;  ┌─┐  ─
;;  └─┘
;; だけ入力した後「繰返しキー」を連続して押すだけで描くことができます。
;;
;; ● 繰返し予測の方法
;;
;; 入力の繰返しの予測手法はいろいろ考えられますが、dmacro.elでは
;; 以下のような優先度をもたせています。
;;
;;  (1) 同じ入力パタンが予測の直前に2度繰返されている場合はそれを
;;      優先する。繰返しパタンが複数ある場合は長いものを優先する。
;;
;;      例えば、「かわいいかわいい」という入力では「かわいい」と
;;      いうパタンが繰り返されたという解釈と、「い」というパタンが
;;      繰り返されたという解釈の両方が可能ですが、この場合
;;      「かわいい」を優先します。
;;
;;  (2) (1)の場合にあてはまらず、直前の入力列<s>がそれ以前の入力列の
;;      一部になっている場合(直前の入力が<s> <t> <s>のような形に
;;      なっている場合)は、まず<t>を予測し、その次から<s> <t>を予測
;;      する。このとき<s>の長いものを優先し、その中では<t>が短いもの
;;      を優先する。
;;
;;      例えば「abracadabra」という入力では、<s>=「abra」が最長なので
;;      <s> <t>=「cadabra」の予測が優先されます。
;;
;; ● XEmacs 対応、Super, Hyper, Alt キーの対応について
;;
;; この版では XEmacs にも対応しました。
;; 現在のところ GNU Emacs 18, 19, 20, 21, XEmacs 21 で
;; 動作することが確認できています。
;; また従来の dmacro では Super, Hyper, Alt のキー入力を
;; 正しく扱うことができませんでしたが、このバージョンでは
;; 扱えるようになっています。
;; 繰り返しのキーとして *dmacro-key* に Super, Hyper, Alt, Meta
;; を含めたキーを使うこともできますが、ただしその際は
;; 以下の注意に従って下さい。
;;
;; ● *dmacro-key* の指定
;;
;; GNU Emacs の場合
;;   Modifier key として Control のみが使われる場合は "\C-t" のような
;;   文字列として指定できます。Meta, Super, Hyper, Alt を利用する場合には
;;   それぞれ [?\M-t], [?\s-t], [?\H-t], [?\A-t] のように指定して下さい。
;;
;; XEmacs の場合
;;   Meta key を使う場合でも上記のような制限はありません。Super 等を使う
;;   場合には [(super t)] のように指定して下さい。
;;
;; ● 設定方法
;;
;;  .emacsなどに以下の行を入れて下さい。
;;
;; (defconst *dmacro-key* "\C-t" "繰返し指定キー")
;; (global-set-key *dmacro-key* 'dmacro-exec)
;; (autoload 'dmacro-exec "dmacro" nil t)
;;
;; オリジナルの連絡先:
;; 増井俊之
;; シャープ株式会社 ソフトウェア研究所
;; masui@shpcsl.sharp.co.jp
;;
;; 2002/6/3現在の連絡先:
;; 増井俊之
;; (株)ソニーコンピュータサイエンス研究所
;; masui@acm.org
;;

(defvar ndmacro-array-type
  (if (and (boundp 'emacs-major-version)
	   (>= emacs-major-version 19))
      'vector 'string)
  "ndmacro の内部で処理する配列の種類。
emacs 19 以上ならデフォルトで vector にする。
string では hyper, super, alt を含んだ入力の繰り返しが
正しく処理できないので注意。
GNU Emacs 18 (Nemacs) を使っている方以外は vector で問題ありません。")

(fset 'ndmacro-concat
      (cond ((eq ndmacro-array-type 'string) 'concat)
	    ((eq ndmacro-array-type 'vector) 'vconcat)))

(fset 'ndmacro-subseq
      (cond ((featurep 'xemacs) 'subseq)
            ((and (eq ndmacro-array-type 'vector)
                  (boundp 'emacs-major-version)
                  (eq emacs-major-version 19))
             (require 'cl)
             'subseq)
            (t 'substring)))

(defvar *ndmacro-arry* nil "繰返しキー配列")
(defvar *ndmacro-arry-1* nil "繰返しキーの部分配列")
(defvar *ndmacro-steps* nil)

(defconst *ndmacro-re-digits* "[0-9]+")

(setq ndmacro-key
      (cond ((eq ndmacro-array-type 'string)
             *ndmacro-key*)
            (t
             (let ((key *ndmacro-key*))
               (cond ((featurep 'xemacs)
                      (if (arrayp key)
                          (mapvector 'character-to-event key)
                        (vector (character-to-event key))))
                     (t
                      (vconcat key)))))))

(setq ndmacro-keys (ndmacro-concat ndmacro-key ndmacro-key))

(defun ndmacro-to-array (v)
  (vconcat (mapcar 'identity v)))

(defun ndmacro-build-re (s)
  (replace-regexp-in-string "[0-9]+" "[0-9]+" (regexp-quote s)))

(defun ndmacro-number-list (str)
  (setq str (concat (mapcar 'ndmacro-event str)))
  (let ((ptr 0)
        lst)
    (while (string-match *ndmacro-re-digits* str ptr)
      (setq lst (cons (string-to-number (match-string 0 str)) lst))
      (setq ptr (match-end 0)))
    (reverse lst)))

(defun ndmacro-mapcar (op seq1 seq2)
  (if (and (consp seq1) (consp seq2))
      (cons (funcall op (car seq1) (car seq2))
            (ndmacro-mapcar op (cdr seq1) (cdr seq2)))))

(defun ndmacro-step-list (str1 str2)
  (ndmacro-mapcar #'- (ndmacro-number-list str2) (ndmacro-number-list str1)))

(defun ndmacro-count ()
  (if *ndmacro-arry*
      (let ((arry (concat *ndmacro-arry*))
            (steps *ndmacro-steps*)
            (str ""))
        (while (string-match *ndmacro-re-digits* arry)
          (let* ((mstr (match-string 0 arry))
                 (num (string-to-number mstr))
                 (num2 (+ num (car steps)))
                 (beg (match-beginning 0))
                 (end (match-end 0))
                 (fmt (if (eq (aref mstr 0) ?0)
                          (concat "%0" (number-to-string (length mstr)) "d")
                        "%d")))
            (setq str (concat str (substring arry 0 beg) (format fmt (if (> 0 num2) 0 num2))))
            (setq steps (cdr steps))
            (setq arry (substring arry end))))
        (setq *ndmacro-arry* (ndmacro-to-array (concat str arry))))))

(defun ndmacro-next-pos (ary p)
  (if (ndmacro-digit-p (aref ary p))
      (let ((q (1+ p))
            (len (length ary)))
        (while (and (< q len) (ndmacro-digit-p (aref ary q)))
          (setq q (1+ q)))
        q)
    (1+ p)))

(defun ndmacro-digit-p (ch)
  (and (<= ?0 ch) (<= ch ?9)))

(defun ndmacro-exec ()
  "キー操作の繰返しを検出し実行する"
  (interactive)
  (let ((s (ndmacro-get)))
    (if (null s)
	(message "操作の繰返しが見つかりません")
      (execute-kbd-macro s)
      )
    ))

(defun ndmacro-event (e)
  (cond
   ((integerp e)
    (if (characterp e) e 0))
   ((eq e 'backspace) 8)
   ((eq e 'tab) 9)
   ((eq e 'enter) 13)
   ((eq e 'return) 13)
   ((eq e 'escape) 27)
   ((eq e 'delete) 127)
   (t 0)
   ))

(defun ndmacro-recent-keys ()
  (cond ((eq ndmacro-array-type 'vector)
         (vconcat (mapcar 'ndmacro-event (recent-keys))))
	((eq ndmacro-array-type 'string)
	 (let ((s (recent-keys)) )
	   (if (stringp s) s
	     (concat (mapcar 'ndmacro-event s))
	     )))))

(defun ndmacro-get ()
  (let ((rkeys (ndmacro-recent-keys)) arry)
    (if (if (featurep 'xemacs)
            (let ((keys (vconcat ndmacro-key
                                 (or *ndmacro-arry-1* *ndmacro-arry*)
                                 ndmacro-key)))
              (equal keys
                     (subseq rkeys (- (length keys)))))
          (equal ndmacro-keys (ndmacro-subseq rkeys (- (length ndmacro-keys)))))
        (progn
          (setq *ndmacro-arry-1* nil)
          (ndmacro-count))
      (setq arry (ndmacro-search (ndmacro-subseq rkeys 0 (- (length ndmacro-key)))))
      (if (null arry)
          (setq *ndmacro-arry* nil)
        (let ((s1 (car arry))
              (s2 (cadr arry))
              (steps (caddr arry)))
          (setq *ndmacro-arry* (ndmacro-concat s2 s1)
                *ndmacro-arry-1* (if (equal s1 "") nil s1))
          (setq last-kbd-macro *ndmacro-arry*)
          (setq *ndmacro-steps* steps)
          (if (equal s1 "")
              (progn
                (setq *ndmacro-arry-1* nil)
                (ndmacro-count))
            (setq *ndmacro-arry-1* (ndmacro-to-array s1))))
        ))))

(defun ndmacro-search (array)
  (let* ((arry (ndmacro-array-reverse array))
         (sptr (ndmacro-next-pos arry 0))
         (osptr 0)
         (beg-end (ndmacro-array-search (ndmacro-subseq arry 0 sptr) arry sptr))
         (dptr0 (car beg-end))
         (dptr dptr0)
         (zptr0 (cdr beg-end)) (zptr zptr0) zzptr
         maxptr)
    (while (and dptr0
                (not (ndmacro-array-search ndmacro-key (ndmacro-subseq arry sptr dptr0))))
      (if (= dptr0 sptr)
          (setq maxptr sptr zzptr zptr0))
      (setq osptr sptr)
      (setq sptr (ndmacro-next-pos arry sptr))
      (setq dptr dptr0 zptr zptr0)
      (setq beg-end (ndmacro-array-search (ndmacro-subseq arry 0 sptr) arry sptr))
      (setq dptr0 (car beg-end)
            zptr0 (cdr beg-end))
      )
    (if (null maxptr)
        (let ((predict-arry (ndmacro-array-reverse (ndmacro-subseq arry osptr dptr))))
          (if (ndmacro-array-search ndmacro-key predict-arry)
              nil
            (let ((s1 (ndmacro-array-reverse (ndmacro-subseq arry dptr zptr)))
                  (s2 (ndmacro-array-reverse (ndmacro-subseq arry 0 osptr))))
              `(,predict-arry ,s2 ,(ndmacro-step-list (ndmacro-concat s1 predict-arry)
                                                     (ndmacro-concat s2 predict-arry))))))
      (let ((t1 (ndmacro-array-reverse (ndmacro-subseq arry maxptr zzptr)))
            (t2 (ndmacro-array-reverse (ndmacro-subseq arry 0 maxptr))))
        `("" ,t2 ,(ndmacro-step-list t1 t2))))))

(defun ndmacro-array-reverse (arry)
  (ndmacro-concat (reverse (mapcar 'identity arry))))

(defun ndmacro-array-search (pat arry &optional start)
  (let* ((len (length pat))
	 (max (- (length arry) len))
	 p found
         (patstr (concat (mapcar 'ndmacro-event pat)))
         (arrystr (concat (mapcar 'ndmacro-event arry)))
	 )
    (setq p (if start start 0))
    (while (and (not found) (<= p max))
      (setq found (string-match (ndmacro-build-re patstr) arrystr p))
      (if (not found) (setq p (1+ p)))
      )
    (if found (cons (match-beginning 0) (match-end 0)))
    ))

(provide 'ndmacro)

;;; ndmacro.el はここまで
