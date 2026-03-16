import VersoBlog

import Site

open Verso Genre Blog Site Syntax

open Output Html Template Theme in
def theme : Theme := { Theme.default with
  primaryTemplate := do
    let navLinks := {{
      <nav>
        <a href="/publications">"Publications"</a>
        <a href="/cv">"CV"</a>
        <a class="github-link" href="https://github.com/volodeyka" title="GitHub"><img src="/static/github.svg" alt="GitHub"/></a>
      </nav>
    }}
    return {{
      <html lang="en">
        <head>
          <meta charset="utf-8"/>
          <meta name="viewport" content="width=device-width, initial-scale=1"/>
          <link rel="preconnect" href="https://fonts.googleapis.com"/>
          <link rel="preconnect" href="https://fonts.gstatic.com"/>
          <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap"/>
          <title>{{ (← param (α := String) "title") }} " — Vladimir Gladshtein"</title>
          <link rel="stylesheet" href="/static/style.css"/>
          {{← builtinHeader }}
        </head>
        <body>
          <header class="site-header">
            <div class="header-inner">
              <a class="site-name" href="/">"Vladimir Gladshtein"</a>
              {{ navLinks }}
            </div>
          </header>
          <main>
            {{← param "content" }}
          </main>
          <footer class="site-footer">
            <p>"Powered by " <a href="https://github.com/leanprover/verso">"Verso"</a> " and " <a href="https://lean-lang.org">"Lean 4"</a>"."</p>
          </footer>
        </body>
      </html>
    }}
  }
  |>.override #[] {
    template := do
      return {{<div class="frontpage">{{← param "content"}}</div>}},
    params := id
  }


def site' : Site := site Site.FrontPage /
  static "static" ← "static_files"
  "publications" Site.Publications
  "cv" Site.CV


def main := blogMain theme site'
