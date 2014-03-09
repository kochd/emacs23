;;; opsi-mode-el -- Major mode for editing OPSI files

;; Author: Daniel Koch <koch@triple6.org>
;; Created: 07 Mar 2014
;; Keywords: OPSI major-mode
;; Version: 0.4

;; Copyright (C) 2014 Daniel Koch <koch@triple6.org>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

(defvar opsi-mode-hook nil)
(defvar opsi-mode-map
  (let ((opsi-mode-map (make-keymap)))
;    (define-key opsi-mode-map "\C-j" 'newline-and-indent)
    opsi-mode-map)
  "Keymap for OPSI major mode")


;; ,----
;; | File-Extensions
;; `----
(add-to-list 'auto-mode-alist '("\\.opsi.*\\'" . opsi-mode))
(add-to-list 'auto-mode-alist '("\\.ins\\'" . opsi-mode))

;; ,----
;; | Syntax
;; `----
(setq opsi-keywords '(
"Actions" "Initial"
"actions" "initial"
))

(setq opsi-types '(
"WinBatch" "DosBatch" "DosInAnIcon" "Sub" "Files" "Patch" "Registry"
"Winbatch" "Dosbatch" "Dosinanicon"
"winbatch" "dosbatch" "Dosinanicon" "sub" "files" "patch" "registry"

))

(setq opsi-events '(
"ScriptPath" "ScriptDrive"
"Scriptpath" "Scriptdrive"
"scriptpath" "scriptdrive"

"SystemDrive"
"Systemdrive"
"systemdrive"

"ProgramFiles32Dir" "ProgramFiles64Dir" "ProgramFilesDir"
"programfiles32dir" "programfiles64dir" "programfilesdir"
"Programfiles32dir" "Programfiles64dir" "Programfilesdir"

"CurrentProfileDir" "CurrentDesktopDir"
"currentprofiledir" "currentdesktopdir"
"Currentprofiledir" "Currentdesktopdir"

"AllUsersProfileDir"
"Allusersprofiledir"
"allusersprofiledir"


))

(setq opsi-functions '(
"SetLogLevel" "ExitOnError" "ScriptErrorMessages" "TraceMode" "StayOnTop"
"Setloglevel" "Exitonerror" "Scripterrormessages" "Tracemode" "Staynntop"
"setloglevel" "exitonerror" "scripterrormessages" "tracemode" "stayontop"

"Comment" "Message" "ShowBitmap"
"Showbitmap"
"comment" "message" "showbitmap"

"Set" "DefVar" "DefStringList"
"Set" "Defvar" "Defstringlist"
"SET" "DEFVAR" "DEFSTRINGLIST"
"set" "defvar" "defstringlist"

"If" "Or" "Not" "EndIf" "Else"
"IF" "OR" "NOT" "Endif" "ENDIF" "ELSE"
"if" "or" "not" "endif" "else"

"for" "FOR" "For"
"in" "IN" "In"

"Include_Insert" "Include_Append" "Sub"
"Include_insert" "Include_append"
"include_insert" "include_append" "sub"

"LogError" "IsFatalError"
"isFatalError"
"Logerror" "Isfatalerror"
"logerror" "isfatalerror"
"logError"

"HasMinimumSpace"
"Hasminimumspace"
"hasminimumspace"

"getReturnListFromSection" "getProductProperty" "getMsVersionInfo" "getLastExitCode"
"GetReturnListFromSection" "GetProductProperty" "GetMSVersionInfo" "GetLastExitCode"
"Getreturnlistfromsection" "Getproductproperty" "Getmsversioninfo"
"getreturnlistfromsection" "getproductproperty" "getmsversioninfo" "getlastexitCode"

"GetSystemType"
"Getsystemtype"
"getsystemtype"


"takeString" "splitString"
"Takestring" "Splitstring"
"takestring" "splitstring"

))

;; create the regex string for each class of keywords
;; []
(setq opsi-keywords-regexp (concat "\\[" (regexp-opt opsi-keywords ) "\\]"))

;; Section_
(setq opsi-type-regexp (concat "\\(\\[\\|\\)" (regexp-opt opsi-types ) "_\\(_\\|\\w\\)*\\(\\]\\|\\)"))

;; %
(setq opsi-event-regexp (concat "%" (regexp-opt opsi-events) "%"))

;; $
(setq opsi-constant-regexp "\\<\$\\(\\w\\|\_\\|\-\\)*\$\\>")

(setq opsi-functions-regexp (regexp-opt opsi-functions 'words))

;;; Clear mem
(setq opsi-keywords nil)
(setq opsi-types nil)
(setq opsi-events nil)
(setq opsi-functions nil)

;; create the list for font-lock.
;; each class of keyword is given a particular face
(setq opsi-font-lock-keywords
  `(
    (,opsi-type-regexp . font-lock-type-face)
    (,opsi-constant-regexp . font-lock-constant-face)
    (,opsi-event-regexp . font-lock-builtin-face)
    (,opsi-functions-regexp . font-lock-function-name-face)
    (,opsi-keywords-regexp . font-lock-keyword-face)
    ;; note: order above matters. “opsi-keywords-regexp” goes last because
))

(defvar opsi-mode-syntax-table
  (let ((opsi-mode-syntax-table (make-syntax-table )))

    ; Use ";" for commands
	(modify-syntax-entry ?\; "< b" opsi-mode-syntax-table) ; ";" Start a comment
	(modify-syntax-entry ?\n "> b" opsi-mode-syntax-table) ; "\n" Ends a comment
	(modify-syntax-entry ?\' "\""  opsi-mode-syntax-table) ; "'" qoutes a string
	(modify-syntax-entry ?\\ " "  opsi-mode-syntax-table)  ; "\" does nothing ( Escapes by default )


	opsi-mode-syntax-table)
  "Syntax table for opsi-mode")


;; ,----
;; | Indentation
;; `----
(defun opsi-indent-line ()
  "Indent current line as OPSI code."
  (interactive)
  (beginning-of-line)

    (let ((not-indented t) cur-indent)
        (if (looking-at "^[ \t]*\\(Endif\\|Else\\)") ; If the line we are looking at is the end of a block, then decrease the indentation
	      (progn
		(save-excursion
		    (forward-line -1)
		      (setq cur-indent (- (current-indentation) tab-width)))
		(if (< cur-indent 0) ; We can't indent past the left margin
		    (setq cur-indent 0)))
	  (save-excursion
	      (while not-indented ; Iterate backwards until we find an indentation hint
		(forward-line -1)
		(if (looking-at "^[ \t]*Endif") ; This hint indicates that we need to indent at the level of the Endif token
		    (progn
			(setq cur-indent (current-indentation))
			  (setq not-indented nil))
		    (if (looking-at "^[ \t]*\\(If\\|Else\\)") ; This hint indicates that we need to indent an extra level
			(progn
			    (setq cur-indent (+ (current-indentation) tab-width)) ; Do the actual indenting
			    (setq not-indented nil))
		      (if (bobp)
			  (setq not-indented nil)
			))))))
	(if cur-indent
	    (indent-line-to cur-indent)
	  (indent-line-to 0))


)) ; If we didn't see an indentation hint, then allow no indentation



;; ,----
;; | Key Bindings
;; `----
(define-key opsi-mode-map (kbd "<backtab>") 'indent-relative)

;; ,----
;; | Mode Definition
;; `----

(defun opsi-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map opsi-mode-map)
  (set-syntax-table opsi-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(opsi-font-lock-keywords))
  ;; Register our indentation function
  (set (make-local-variable 'indent-line-function) 'opsi-indent-line)
  (setq major-mode 'opsi-mode)
  (setq mode-name "OPSI")
  (run-hooks 'opsi-mode-hook))

(provide 'opsi-mode)
(provide 'opsi-mode-map)

;;; opsi-mode.el ends here
