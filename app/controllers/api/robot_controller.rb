class Api::RobotController < ApplicationController
  before_action :check_command

  DEFAULT_ORIGIN = '(0, 0)'

  def orders
    render json: {location: []}
  end

  private

  def check_command
    command = params[:command]
    if command.blank?
      render json: {error: 'No command found.'}  
    else
      if command.size == 2
        place = command.first
        if right_format_of?(place)
          debugger
          place_arr = get_place_arr(place)
          x = place_arr[0].to_i
          y = place_arr[1].to_i
          direction = place_arr[2]
        else
          render json: {error: 'Place command have wrong format.'}
        end
      else
        render json: {error: "Proper command not found. It should be like ['PLACE 0,0,NORTH', 'MOVE REPORT']"}
      end
    end
  end

  def right_format_of?(place)
    get_place_arr(place).size >= 3
  end

  def get_place_arr(place)
    place.split(',')
  end
end