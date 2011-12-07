require 'rag'

$spec_dir = Pa(__FILE__).dir

ENV['HOME'] = $spec_dir.join2('data')

Rag::Rc = Optimism.require "#{$spec_dir}/data/systemrc", "#{$spec_dir}/data/homerc"
