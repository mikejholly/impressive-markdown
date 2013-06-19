sys      = require 'sys'
fs       = require 'fs'
_        = require 'underscore'
markdown = require('markdown').markdown

md    = process.argv.pop()
title = process.argv.pop()

unless fs.existsSync md
  console.log "Can't find `#{md}`."
  process.exit()

template = fs.readFileSync './template.html', 'utf-8'
input    = fs.readFileSync md, 'utf-8'

parts = input.split /---/
parts = _.map parts, (p) ->
  """
  <div class="step">
    #{markdown.toHTML(p)}
  </div>
  """

parts = _.reject parts
slides = parts.join("\n")

template = template.replace '{{ title }}', title
template = template.replace '{{ slides }}', slides

fs.writeFile 'present.html', template