class MainController < Controller
  def index
    @test = "Some dump text here"
    @arr = %w(one two three)
  end
  def hello
    @greeting = "Hello world"
  end
end
