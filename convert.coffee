sys      = require 'sys'
fs       = require 'fs'
_        = require 'underscore'
markdown = require('markdown').markdown

# Convenience renames
exists = fs.existsSync
puts   = console.log
read   = (input) -> fs.readFileSync input, 'utf-8'

# File to process and presention title
markdownFile = process.argv[2];

# Object passed to template function
context =
  title: 'Presentation'

# Bust if input file is not found
unless exists markdownFile
  console.log "Markdown file not specified"
  process.exit()

# Load template and markdown file
template = read './template.html'
input    = read markdownFile

# Split each subsection by each occurrance of '~'
parts = input.split '~'

# Ignore blank lines
parts = _.reject parts, (p) -> p.length < 1

# Format each section. Convert MD to HTML
parts = _.map parts, (p) ->
  """
  <div class="step">
    #{markdown.toHTML(p)}
  </div>
  """

# Recombine sections
context.slides = parts.join "\n"

# Generate final HTML with underscore template
puts _.template template, context
