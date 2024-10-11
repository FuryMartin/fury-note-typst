# simple-typst-note

## Example
![](./assets/example.png)

## Usage 

```rust
#import "lib.typ": *

#let title = "Hello, World!"
#let author = (
  name: "Example",
  email: "test@email.com"
)
#let bib-path = "./refer.bib"

#show: note.with(
  title: [#title],
  author: author,
  bib-path:bib-path,
  lang: "zh", 
  toc: false,
)

= Introduction

#lorem(50)

```

## Requirements

- Install `Family Song` for better font effect. You can visit [Keldos-Li/typora-latex-theme-fonts](https://github.com/Keldos-Li/typora-latex-theme-fonts/tree/main) for more infomation. 

## Advices

- VSCode + [tynymist-typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) is recommended for writing typst notes.