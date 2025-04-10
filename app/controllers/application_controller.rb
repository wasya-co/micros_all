
##
## This controller is not used!
##
class ApplicationController < ActionController::Base

  def home
    # flash[:notice] = 'okk'
  end

  def section
    render "sections/#{params[:which]}", layout: 'bootstrap'
  end

  def sections_one
    render 'sections/one', layout: 'bootstrap'
  end

  def sections_carousel
    render 'sections/carousel', layout: 'bootstrap'
  end

  def test_exception
    throw 'test exception'
  end

  ##
  ## private
  ##
  private

  ## v0.1.0
  def flash_alert what
    # puts! what, 'what'

    flash[:alert] ||= []
    if String == what.class
      str = what
    elsif Array == what.class
      what.each do |wha|
        flash[:alert] << wha
      end
    else
      str = "Cannot create/update #{what.class.name}: #{what.errors.full_messages.join(', ')} ."
      flash[:alert] << str
    end
  end

  def flash_notice what
    flash[:notice] ||= []
    if String == what.class
      str = what
    else
      str = "Created/updated #{what.class.name} ."
    end
    flash[:notice] << str
  end


end
