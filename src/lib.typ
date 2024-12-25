#let note(
  // The Thesis Title
  title: [],
  // Author information, dictionary type
  author: (name: "", email: "", department: "", affiliation: ""),
  //Your thesis abstract. Can be omitted if you dont have one.
  abstract: none,
  // The thesis papersize. Default is A4. Affects margins.
  papersize: "a4",
  // The result of a call to the `bibliography` function or none
  bib: none,
  // BibTeX style
  bibstyle: "ieee",
  // The language of the document. Default is "zh".
  lang: "zh",
  //The appendix
  appendix: none,
  // The TOC
  toc: true,
  // two column layout
  column: 1,
  // The document's body
  body
) = {

  let author-name = if "name" in author { author.name } else { none }
  let author-email = if "email" in author { author.email } else { none }
  let author-department = if "department" in author { author.department } else { none }
  let author-affiliation = if "affiliation" in author { author.affiliation } else { none }

  set document(title: title, author: author-name)
  
  let main-font = ("Times New Roman", "Family Song"）
  # if using Mac OS, replace "Kaiti" with "Kaiti SC"
  let italic-font = ("Times New Roman",  "Kaiti")
  set text(font: main-font, size: 12pt, lang: lang)

  set heading(numbering: "1.1")

  show heading: it => [
    #block(it)
    #v(0.4em)
  ]

  set par(justify: true, leading: 0.8em, spacing: 1.5em)

  set page(
    paper: papersize,
    numbering: "1"
  )

  align(center, text(20pt)[*#title *])


  if author-name != none {
    align(center)[
      #author-name
    ]
    set text(font: italic-font, size: 12pt, lang: lang)
    align(center)[
      #if author-department != none [#author-department \ ]
      #if author-affiliation != none [#author-affiliation \ ]
      #if author-email != none [#link("mailto:" + author-email) \ ]
    ]
  }
  
  set list(indent: 1.2em)
  set math.mat(delim: "[")
  set math.vec(delim: "[")
  
  set math.equation(numbering: "(1)")

  show link: set text(fill: blue, style: "italic", weight: "bold")

  // Configure citations and bibliography style
  set bibliography(style: bibstyle, title: if lang == "en" { [References] } else { [参考文献] })

    // Display the abstract
  let show-abstract = {
    if abstract != none and lang != "zh"{
      // English abstract
      v(2.5em, weak: true)
      set text(1em)
      show: pad.with(x: 1cm)
      align(center,text(font:main-font, size: 1.3em, strong[Abstract]))
      abstract
    } else if abstract != none and lang == "zh"{
      // German abstract
      v(2.5em, weak: true)
      set text(1em)
      show: pad.with(x: 1cm)
      align(center,text(font:main-font, size: 1.3em, strong[摘要]))
      abstract
    } else {
      // No abstract
      v(2em, weak: true)
    }
  }

  // Table of Contents Style
  show outline.entry.where(
    level: 1,
  ): it => {
    v(15pt, weak: true)
    text(font:main-font,[
      #strong(it.body)
      #box(width: 1fr, repeat[])
      #strong(it.page)
      ])}

  show outline.entry.where(
    level: 2,
  ): it => {
    it.body
    box(width: 1fr, repeat[.])
    it.page}

  show outline.entry.where(
    level: 3,
  ): it => {
    it.body
    box(width: 1fr, repeat[.])
    it.page}
    
  // Display the table of contents.
  if toc == true { 
    if lang == "zh"{
      outline(title: [目录], indent: auto)
    } else {
      outline(title: [Table of Contents], indent: auto)
    }
  }
  
  show-abstract

  v(2em, weak: true)
  show: rest => columns(column, rest)


  body

  if bib != none {
    set text(lang: "en")
    bib
  }

  // Appendix
  if appendix != none {
    let appendix_title = if lang == "en" { [Appendix] } else { [附录] }

    set heading(numbering: none)
    [= Anhang]
    set outline(depth: 2)
    set heading(numbering: (..nums) => {
      nums = nums.pos()
      if nums.len() == 1 {
        return appendix_title + " " + numbering("A.", ..nums)
      } else if nums.len() == 2 {
        return numbering("A.1.", ..nums)
      } else {
        return numbering("A.1.", ..nums)
      }
    })
  show heading.where(level: 3): set heading(numbering: "A.1", outlined: false)
  show heading.where(level: 2): set heading(numbering: "A.1", outlined: false)
  counter(heading).update(0)
  appendix
  }
}
#let codecell(
  doc, 
  // Vertical shift (space before cell)
  vertical:0em
) = {
  if vertical != none {
    v(vertical)
  }
  block(
    align(left,doc),
    stroke: 0.7pt , 
    fill: rgb("#eee"), 
    outset: 5pt, 
    radius: 5pt, 
    width: 95%,
    breakable: true
  )
}
