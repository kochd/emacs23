;; batch byte compile of all elisp (.el) files in a dir and subdirs
;; Eval this buffer to use it
(require 'find-lisp)

(mapc
 (lambda (x) (byte-compile-file x))
 (find-lisp-find-files
  (expand-file-name (concat (file-name-directory (or load-file-name buffer-file-name)) default-directory))
  "\\.el$"))
