require "ostruct"
class Rag
  Rc = OpenStruct.new
  Rc.pa = OpenStruct.new
  Rc.pa.config = Pa(ENV['HOME']).join('.ragrc')
  Rc.pa.app = Pa(__FILE__).dir2.parent(2)

  Rc.pa.app_config = Rc.pa.app.join('.ragrc')
  Rc.pa.data = Rc.pa.app.join('datas')
  Rc.pa.template = Rc.pa.app.join('templates')
end
