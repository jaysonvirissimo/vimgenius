class CommandsController < ApplicationController
  expose(:lesson) { Lesson.find_by_slug(params[:lesson_id]) }
  expose(:level) { Level.find_by_slug(params[:level_id]) }
  expose(:commands) { level.commands }
  expose(:command)
  expose(:next_command) { next_command }
  expose(:current_cycle) { cycle }
  expose(:next_level) { next_level }


  def show
    if cycle == cycles_till_completion
      render partial: 'shared/congrats', status: 200
    else
      render partial: 'shared/command', status: 200
    end
  end

  private

  def next_level
    lesson.levels.where(sequence_number: level.sequence_number+1).first
  end

  def cycles_till_completion
    2
  end

  def cycle
    current_cycle = params[:current_cycle].to_i
    current_index == 0 ? current_cycle += 1 : current_cycle
  end

  def next_command
    commands[next_index]
  end

  def current_index
    commands.index(command)
  end

  def next_index
    new_index = current_index + 1
    new_index < (commands.size) ? new_index : 0
  end

end