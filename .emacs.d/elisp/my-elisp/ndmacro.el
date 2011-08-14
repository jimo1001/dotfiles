;;; ndmacro.l --- �A�ԋ@�\�t��dmacro
;;
;; $Id: ndmacro.l,v 1.1 2003/06/30 13:33:41 kia Exp $
;;
;; ����r�V�����dmacro.el�ɂ�����A�Ԃ̋@�\�������������̂ł��Bndmacro.l
;; �ł͐�����̕����ɂ����铮�삪�I���W�i����dmacro.el�Ƃ͈قȂ�܂��B
;; 
;; �Ȃ��A����dmacro.el��Emacs�p�ł����A����ndmacro.l��xyzzy��p�ł��B
;;
;;
;;; �C���X�g�[��
;;
;; ���[�h�p�X�̒��̂����ꂩ�̏ꏊ�֔z�u���āA.xyzzy�Ɏ��̂悤�ɐݒ肵�Ă��������B
;; ���蓖�Ă�L�[�͕K�v�ɉ����ĕύX���Ă��������B
;;
;;     (defconstant *ndmacro-key* #\C-t)
;;     (global-set-key *ndmacro-key* 'ndmacro-exec)
;;     (autoload 'ndmacro-exec "ndmacro" t)
;;
;;
;;; �A�ԋ@�\
;;
;; �Ⴆ�΃��[�U��
;;     100,101,
;; �Ɠ��͂�����u�J��Ԃ��L�[�v�������ƁAndmacro.l �� 0����9�̐�������Ȃ�
;; ������𐔒l�Ƃ��ĔF�����A���̐��l�̑������s���Ȃ�����͑�����J��Ԃ���
;; ���B���̌��ʂ̕������
;;     100,101,102,
;; �ƂȂ�܂��B���l�𑝉������邩���������邩�A�����Ă��̗ʂ��ǂ̂��炢�ɂ�
;; �邩�̓e�L�g�[�ɗ\�����܂��B
;;
;; �������A���l������������ꍇ�A�������������ʂ����l�ɂȂ�Ƃ��̓[�����Ԃ�
;; ��܂��B���Ȃ킿��x�[���ɂȂ�Ƃ���ȍ~�͌������܂���B
;;
;; ���l�����̍ŏ�ʂ̈ʂ���ȏ��`0'�Ŗ��߂��Ă���Ƃ��́A���̃J������
;; �ɍ��킹�ď�ʂ�`0'�Ŗ��߂Ă����܂��B�Ⴆ��
;;     abc001.txt
;;     abc002.txt
;; �Ɠ��͂������Ɓu�J��Ԃ��L�[�v�������ƁA���ʂ�
;;     abc001.txt
;;     abc002.txt
;;     abc003.txt
;; �ɂȂ�܂��B
;;
;; �����ɕ����̐��l�𑝌��ł��܂��B�Ⴆ�΁A
;;     2x1=2
;;     2x2=4
;; �Ɠ��͂�����u�J��Ԃ��L�[�v�������ƁA���ʂ�
;;     2x1=2
;;     2x2=4
;;     2x3=6
;; �ɂȂ�܂��B
;;
;;
;;; ndmacro.l�Ɋւ���A����
;;
;; kia <kia@geocities.co.jp>
;; http://www.geocities.co.jp/SiliconValley-PaloAlto/5042/


;;; �ȉ��̐��������̓I���W�i����dmacro.el�̂��̂ł��B

;;
;;      dmacro.el - �L�[����̌J�Ԃ����o & ���s
;;
;;	Version 2.0
;;
;;      1993 4/14        original idea by ����r�V���V���[�v
;;                         implemented by ���a�c���������Z�ȑ�
;;                          refinement by ����r�V���V���[�v
;;	1995 3/30 modified for Emacs19 by ����r�V���V���[�v
;;
;;	2002 3              XEmacs�Ή� by �����p�i obata@suzuki.kuee.kyoto-u.ac.jp
;;                                        ���L�s zah07175@rose.zero.ad.jp
;;
;;

;;
;; dmacro.el �́A�J��Ԃ����L�[����񂩂玟�̑����\�������s������
;; ���߂̃v���O�����ł��B����̌J�Ԃ��̌��o�Ƃ��̎��s���w�߂��邽�߂�
;; *dmacro-key* �Ŏw�肷����ʂ́u�J�Ԃ��L�[�v���g�p���܂��B
;;
;; �Ⴆ�΃��[�U��
;;     abcabc
;; �Ɠ��͂�����u�J�Ԃ��L�[�v�������ƁAdmacro.el �� "abc" �̓��͑����
;; �J�Ԃ������o���Ă�������s���A���̌��ʃe�L�X�g��
;;     abcabcabc
;; �ƂȂ�܂��B�܂��A
;;     abcdefab
;; �Ɠ��͂�����u�J�Ԃ��L�[�v�������ƁAdmacro.el �͂���� "abcdef" ��
;; ���͂̌J�Ԃ��Ɣ��f���A�J�Ԃ��̎c��̕�����\�����s���� "cdef" ����͂��A
;; �e�L�X�g��
;;     abcdefabcdef
;; �ƂȂ�܂��B�����ł�����x�u�J�Ԃ��L�[�v�������ƁA"abcdef" �̓���
;; ���J��Ԃ���āA�e�L�X�g��
;;     abcdefabcdefabcdef
;; �ƂȂ�܂��B
;;
;; ������L�[����̌J�Ԃ����F���A���s����邽�߁A�Ⴆ��
;;     line1
;;     line2
;;     line3
;;     line4
;; �Ƃ����e�L�X�g��
;;     % line1
;;     % line2
;;     line3
;;     line4
;; �̂悤�ɕҏW������u�J�Ԃ��L�[�v�������ƃe�L�X�g��
;;     % line1
;;     % line2
;;     % line3
;;     line4
;; �̂悤�ɂȂ�A���̌㉟�����тɎ��̍s���� "% "���ǉ�����Ă����܂��B
;;
;; ���̂悤�ȋ@�\�́A�J�Ԃ��p�^���̔F���ɂ��L�[�{�[�h�}�N���������I��
;; ��`���Ă���ƍl���邱�Ƃ��ł��܂��B�L�[�{�[�h�}�N���̏ꍇ�͑����
;; �J�n����ȑO�ɂ��̂��Ƃ����[�U���F�����ă}�N����o�^����K�v������
;; �܂����Admacro.el �ł͎��ۂɌJ�Ԃ���������Ă��܂�����ł��̂��Ƃ�
;; �C�������ꍇ�ł��u�J�Ԃ��L�[�v�����������ł��̑�����܂����s������
;; ���Ƃ��ł��܂��B�܂��}�N���̒�`���@(����̌�Łu�J�Ԃ��L�[�v������
;; ����)���L�[�{�[�h�}�N���̏ꍇ(�}�N���̊J�n�ƏI�����w�肷��)�ɔ�ׂ�
;; �P���ɂȂ��Ă��܂��B
;;
;; �� �g�p��
;;
;; �E������u��
;;
;; �e�L�X�g���̑S�Ắuabc�v���udef]�ɏC������ꍇ���l���Ă݂܂��B
;; �uabc�v����������L�[����� "Ctrl-S a b c ESC" �ŁA�����
;; "DEL DEL DEL d e f" �Łudef�v�ɏC�����邱�Ƃ��ł��܂��B
;; �����������́uabc�v���������� "Ctrl-S a b c ESC" ����͂������
;; �u�J�Ԃ��L�[�v�������� "DEL DEL DEL d e f" ���\�����s����A�V����
;; �������ꂽ�uabc�v���udef�v�ɏC������܂��B�����ł܂��u�J�Ԃ��L�[�v
;; �������Ǝ��́uabc�v���udef�v�ɏC������܂��B
;; ���̂悤�Ɂu�J�Ԃ��L�[�v�������Ă������Ƃɂ�菇�X�ɕ������
;; �u�����Ă������Ƃ��ł��܂��B
;;
;; �E�r���ɂ�邨�G����
;;
;; �J�Ԃ����܂ފG���ȒP�ɏ������Ƃ��ł��܂��B�Ⴆ�΁A
;;   ��������������������������������������������������������
;;     ����������������������������������������������������
;; �̂悤�ȊG�����������ꍇ�́Akeisen.el �Ȃǂ��g����
;;   ��������
;;     ����
;; �Ə�������Łu�J�Ԃ��v�L�[�������ƁA
;;   ��������
;;     ��������
;; �ƂȂ�A������x�u�J�Ԃ��L�[�v��������
;;   ������������
;;     ������������
;; �ƂȂ�܂��B���l��
;;  ������������������������������������������������
;;  ������������������������������������������������
;; �̂悤�ȊG��
;;  ������  ��
;;  ������
;; �������͂�����u�J�Ԃ��L�[�v��A�����ĉ��������ŕ`�����Ƃ��ł��܂��B
;;
;; �� �J�Ԃ��\���̕��@
;;
;; ���͂̌J�Ԃ��̗\����@�͂��낢��l�����܂����Admacro.el�ł�
;; �ȉ��̂悤�ȗD��x���������Ă��܂��B
;;
;;  (1) �������̓p�^�����\���̒��O��2�x�J�Ԃ���Ă���ꍇ�͂����
;;      �D�悷��B�J�Ԃ��p�^������������ꍇ�͒������̂�D�悷��B
;;
;;      �Ⴆ�΁A�u���킢�����킢���v�Ƃ������͂ł́u���킢���v��
;;      �����p�^�����J��Ԃ��ꂽ�Ƃ������߂ƁA�u���v�Ƃ����p�^����
;;      �J��Ԃ��ꂽ�Ƃ������߂̗������\�ł����A���̏ꍇ
;;      �u���킢���v��D�悵�܂��B
;;
;;  (2) (1)�̏ꍇ�ɂ��Ă͂܂炸�A���O�̓��͗�<s>������ȑO�̓��͗��
;;      �ꕔ�ɂȂ��Ă���ꍇ(���O�̓��͂�<s> <t> <s>�̂悤�Ȍ`��
;;      �Ȃ��Ă���ꍇ)�́A�܂�<t>��\�����A���̎�����<s> <t>��\��
;;      ����B���̂Ƃ�<s>�̒������̂�D�悵�A���̒��ł�<t>���Z������
;;      ��D�悷��B
;;
;;      �Ⴆ�΁uabracadabra�v�Ƃ������͂ł́A<s>=�uabra�v���Œ��Ȃ̂�
;;      <s> <t>=�ucadabra�v�̗\�����D�悳��܂��B
;;
;; �� XEmacs �Ή��ASuper, Hyper, Alt �L�[�̑Ή��ɂ���
;;
;; ���̔łł� XEmacs �ɂ��Ή����܂����B
;; ���݂̂Ƃ��� GNU Emacs 18, 19, 20, 21, XEmacs 21 ��
;; ���삷�邱�Ƃ��m�F�ł��Ă��܂��B
;; �܂��]���� dmacro �ł� Super, Hyper, Alt �̃L�[���͂�
;; �������������Ƃ��ł��܂���ł������A���̃o�[�W�����ł�
;; ������悤�ɂȂ��Ă��܂��B
;; �J��Ԃ��̃L�[�Ƃ��� *dmacro-key* �� Super, Hyper, Alt, Meta
;; ���܂߂��L�[���g�����Ƃ��ł��܂����A���������̍ۂ�
;; �ȉ��̒��ӂɏ]���ĉ������B
;;
;; �� *dmacro-key* �̎w��
;;
;; GNU Emacs �̏ꍇ
;;   Modifier key �Ƃ��� Control �݂̂��g����ꍇ�� "\C-t" �̂悤��
;;   ������Ƃ��Ďw��ł��܂��BMeta, Super, Hyper, Alt �𗘗p����ꍇ�ɂ�
;;   ���ꂼ�� [?\M-t], [?\s-t], [?\H-t], [?\A-t] �̂悤�Ɏw�肵�ĉ������B
;;
;; XEmacs �̏ꍇ
;;   Meta key ���g���ꍇ�ł���L�̂悤�Ȑ����͂���܂���BSuper �����g��
;;   �ꍇ�ɂ� [(super t)] �̂悤�Ɏw�肵�ĉ������B
;;
;; �� �ݒ���@
;;
;;  .emacs�ȂǂɈȉ��̍s�����ĉ������B
;;
;; (defconst *dmacro-key* "\C-t" "�J�Ԃ��w��L�[")
;; (global-set-key *dmacro-key* 'dmacro-exec)
;; (autoload 'dmacro-exec "dmacro" nil t)
;;
;; �I���W�i���̘A����:
;; ����r�V
;; �V���[�v������� �\�t�g�E�F�A������
;; masui@shpcsl.sharp.co.jp
;;
;; 2002/6/3���݂̘A����:
;; ����r�V
;; (��)�\�j�[�R���s���[�^�T�C�G���X������
;; masui@acm.org
;;

(defvar ndmacro-array-type
  (if (and (boundp 'emacs-major-version)
	   (>= emacs-major-version 19))
      'vector 'string)
  "ndmacro �̓����ŏ�������z��̎�ށB
emacs 19 �ȏ�Ȃ�f�t�H���g�� vector �ɂ���B
string �ł� hyper, super, alt ���܂񂾓��͂̌J��Ԃ���
�����������ł��Ȃ��̂Œ��ӁB
GNU Emacs 18 (Nemacs) ���g���Ă�����ȊO�� vector �Ŗ�肠��܂���B")

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

(defvar *ndmacro-arry* nil "�J�Ԃ��L�[�z��")
(defvar *ndmacro-arry-1* nil "�J�Ԃ��L�[�̕����z��")
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
  "�L�[����̌J�Ԃ������o�����s����"
  (interactive)
  (let ((s (ndmacro-get)))
    (if (null s)
	(message "����̌J�Ԃ���������܂���")
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

;;; ndmacro.el �͂����܂�
