class HelloController < ApplicationController
  def sayhello
    @msg="hello world"
  end

  #/hello/say/:something
  def say
    case params[:something]
    when "hello" then @msg="saying hello"; render action: :sayhello
    when "goodbye" then @msg="saying goodbye"; render action: :saygoodbye
    when "badword" then render nothing: true
    else 
      render plain: "what do you want me to say?"
    end
  end
end
