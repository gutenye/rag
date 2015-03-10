p:
  root = Pa.expand("../../..", __FILE__)
  home = Pa.join(ENV["HOME"], ".rag")
  homerc = Pa.join(ENV["HOME"], ".ragrc")
  apprc = Pa(".ragrc")
  data = root.join("data")
