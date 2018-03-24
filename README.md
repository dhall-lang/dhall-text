# `dhall-text 1.0.8`

This `dhall-text` package provides a `dhall-to-text` executable which you can
use to template text using the Dhall configuration language.

For example, suppose you save the following files to your current directory:

```haskell
$ cat Person
-- Dhall is a typed programming language

-- This file is the type of an anonymous record
{ name : Text, upvotes : Integer }
```

```haskell
$ cat people
-- Dhall natively supports lists and anonymous records

[ { name = "Maria" , upvotes = 14 }
, { name = "Jordan", upvotes =  2 }
, { name = "Pranav", upvotes =  1 }
]

-- This file has type:
--
--     ./people : List { name : Text, upvotes : Integer }
--
-- ... or just:
--
--     ./people : List ./Person
```

```haskell
$ cat make-item
    -- You can define anonymous functions in Dhall using a backslash (i.e. `\`)
    \(person : ./Person)  -- You can import any type or expression by its path

    -- Dhall supports multiline strings that strip leading whitespace and Dhall
    -- supports string interpolation, too, using `${...}` syntax
->   ''
    <li class="list-group-item">
      <span class="badge">${Integer/show person.upvotes}</span>
      ${person.name}
    </li>
    ''

-- This file has type:
--
--     ./make-item : ./Person -> Text
```

```haskell
$ cat make-items
    -- You can also import any type or expression by its URL
    let List/map = https://ipfs.io/ipfs/Qmbh2ifwcpX9a384vJMehySbV7rdvYhzVbL5ySs84k8BgY/Prelude/List/map
in  let Text/concat = https://ipfs.io/ipfs/Qmbh2ifwcpX9a384vJMehySbV7rdvYhzVbL5ySs84k8BgY/Prelude/Text/concat
in  \(people : List ./Person)
->   Text/concat (List/map ./Person Text ./make-item people)

-- This file has type:
--
--     ./make-items : List ./Person -> Text
```

Templating HTML is just ordinary function application:

```bash
$ dhall-to-text <<< './make-items ./people'
<li class="list-group-item">
  <span class="badge">14</span>
  Maria
</li>

<li class="list-group-item">
  <span class="badge">2</span>
  Jordan
</li>

<li class="list-group-item">
  <span class="badge">1</span>
  Pranav
</li>

```

To learn more about the Dhall configuration language,
[read the tutorial](https://hackage.haskell.org/package/dhall/docs/Dhall-Tutorial.html)

## Quick start

If you have Nix then you can install this package using:

```bash
$ nix-env --install --attr dhall-text --file release.nix
```

## Development status

[![Build Status](https://travis-ci.org/Gabriel439/Haskell-Dhall-JSON-Library.png)](https://travis-ci.org/Gabriel439/Haskell-Dhall-JSON-Library)

I don't expect this library to change unless:

* ... the Dhall language changes, which is possible but not very likely
* ... there are bugs, which is unlikely given how simple the implementation is

## License (BSD 3-clause)

    Copyright (c) 2017 Gabriel Gonzalez
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:
        * Redistributions of source code must retain the above copyright notice,
          this list of conditions and the following disclaimer.
        * Redistributions in binary form must reproduce the above copyright notice,
          this list of conditions and the following disclaimer in the documentation
          and/or other materials provided with the distribution.
        * Neither the name of Gabriel Gonzalez nor the names of other contributors
          may be used to endorse or promote products derived from this software
          without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
    ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
