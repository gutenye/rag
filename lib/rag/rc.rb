p:
  root = Pa.dir(__FILE__).parent(2)
  home = Pa.join(ENV["HOME"], ".rag")
  homerc = Pa.join(ENV["HOME"], ".ragrc")
  apprc = Pa(".ragrc")
  data = root.join("data")
