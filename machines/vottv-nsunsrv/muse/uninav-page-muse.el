;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(add-to-list 'load-path "/home/git/muse-3.20")

(require 'muse-mode)
(require 'muse-html)
(require 'muse-colors)
(require 'muse-wiki)
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)

(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))

(custom-set-variables
 '(muse-html-encoding-default (quote utf-8))
 '(muse-html-meta-content-encoding (quote utf-8))
 '(muse-html-charset-default "utf-8")
 '(muse-file-extension "muse")
 '(muse-mode-auto-p nil)
 '(muse-wiki-allow-nonexistent-wikiword nil)
 '(muse-wiki-use-wikiword nil)
 '(muse-ignored-extensions (quote ("bz2" "gz" "[Zz]" "rej" "orig" "png" "hgignore" "gif"
                                   "css" "jpg" "html" "sh" "lftp" "pdf")))
 )

(defun my-muse-mode-hook ()
  (setq auto-fill-mode t)
  (flyspell-mode 1)
  (footnote-mode 1)
  )
(add-hook 'muse-mode-hook 'my-muse-mode-hook)

(muse-derive-style "uninav-page-html" "html"
                   :header "/var/transas/www/header.tmpl"
                   :footer "/var/transas/www/footer.tmpl")

(muse-derive-style "uninav-page-pdf" "pdf"
                   :header "/var/transas/www/header.tex"
                   :footer "/var/transas/www/footer.tex")

(setq muse-project-alist
      `(
        ("uninav-page"
         (,@(muse-project-alist-dirs "/var/transas/www/") :default "index")
         ,@(muse-project-alist-styles "/var/transas/www/"
                                      "/var/transas/www/"
                                      "uninav-page-html")
         (:base "uninav-page-pdf"
                :path "~/en"
                :include "/alexott-cv-en[^/]*$")
         (:base "uninav-page-pdf"
                :path "~/ru"
                :include "/alexott-cv-ru[^/]*$"))))

(defun muse-gen-relative-name (name)
  (concat
   (file-name-directory (muse-wiki-resolve-project-page (muse-project)))
   name))

(defun muse-mp-detect-language ()
  (let ((lang "NN")
        (cur-dir (file-name-directory (muse-current-file)))
        )
    (let ((smatch (string-match "/\\(ru\\|en\\|de\\)/" cur-dir)))
      (when smatch
        (setq lang (substring cur-dir (+ smatch 1) (+ smatch 3)))))
    lang))

(load-file "/var/transas/www/uninav-page-menu.el")

;; (setq uninav-page-menu '(("ru" . ( ("index.html" . "Главная")
;;                                    ("UniNav/" . "UniNav")
;;                                    ("Technology/" . "Технологическое")
;;                                    ("DebianRepo/" . "Debian")
;;                                    ("Site/" . "Сайт")
;;                                    ("links.html" . "Ссылки")))
;;                          ("en" . ( ("index.html" . "Main")
;;                                    ("UnderCons.html" . "UniNav")
;;                                    ("UnderCons.html" . "Technology")
;;                                    ("UnderCons.html" . "Debian")
;;                                    ("UnderCons.html" . "Site")
;;                                    ("UnderCons.html" . "Links")))))
;;
 
(defun muse-uninav-generate-menu ()
  (let* ((menu-lang (muse-mp-detect-language))
         (menu-struct (assoc menu-lang uninav-page-menu))
         (menu-string "")
         (rel-dir (file-name-directory (muse-wiki-resolve-project-page (muse-project))))
         (rel-path (if (> (length rel-dir) 2)   (substring rel-dir 3) ""))
         (cur-path-muse (muse-current-file))
         (cur-path-html (replace-regexp-in-string "\\.muse" ".html" cur-path-muse))
         )
      (when menu-struct
        (let ((menu-list (if (not (null menu-struct)) (cdr menu-struct))))
          (setq menu-string
                (concat "<ul class=\"avmenu\">"
                        (apply #'concat
                               (mapcar
                                (lambda (x)
                                  (concat "<li><a href=\"" rel-path (car x)
                                          (if (string-match (concat "/" menu-lang "/" (car x))
                                                            cur-path-html)
                                              "\" class=\"current\""
                                            "\"")
                                          ">" (cdr x) "</a></li>"))
                                menu-list))
                        "</ul>"))))
      menu-string))

(defun muse-get-current-project-root (fname)
  (let ((dname (file-truename (file-name-directory fname)))
        (rname (file-name-directory (muse-wiki-resolve-project-page (muse-project)))))
    (file-truename (concat dname rname))))

(defun muse-get-file-relative-name (fname)
  (substring (file-truename fname) (length (muse-get-current-project-root fname))))

(defun generate-change-date (file)
  (when (file-exists-p file)
    (let* ((fa (file-attributes file))
           (mod-time (nth 6 fa)))
      (format-time-string "%d.%m.%Y %R" mod-time))))

(require 'htmlize)

(defun my-htmlize-before-hook ()
  (setq effective-mode "generic")
  (cond ((string= "C++/l" mode-name)(setq effective-mode "cpp"))
        ((string= "Shell-script" mode-name) (setq effective-mode "sh"))
        ((string= "CMAKE" mode-name) (setq effective-mode "cmake")))
  (setq htmlize-css-name-prefix (concat effective-mode "-"))
  (setq htmlize-output-type 'css))

(add-hook 'htmlize-before-hook 'my-htmlize-before-hook)

(defun my-htmlize-region-for-paste (beg end)
  "Htmlize the region and return just the HTML as a string.
This forces the `inline-css' style and only returns the HTML body,
but without the BODY tag.  This should make it useful for inserting
the text to another HTML buffer."
  (let* ((htmlize-output-type 'css)
	 (htmlbuf (htmlize-region beg end)))
    (unwind-protect
	(with-current-buffer htmlbuf
	  (buffer-substring (plist-get htmlize-buffer-places 'content-start)
			    (plist-get htmlize-buffer-places 'content-end)))
      (kill-buffer htmlbuf))))

;; (defadvice htmlize-region-for-paste (around htmlize--region-for-paste compile activate)
;;   "Overrides wrong CSS style for htmlize-region-for-paste"
;;     (my-htmlize-region-for-paste (ad-get-arg 0) (ad-get-arg 1)))
