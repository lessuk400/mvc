class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes # 1
  end

  def resolve(env)
    path = env['REQUEST_PATH'] # 2
    if routes.key?(path) # 3
      ctrl(routes[path]).call # 4
    else
      Controller.new.not_found # 5
    end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error # 6
  end

  private
    def ctrl(string)
    ctrl_name, action_name = string.split('#')
    klass = Object.const_get "#{ctrl_name.capitalize}Controller"
    klass.new(name: ctrl_name, action: action_name.to_sym)
  end
end
