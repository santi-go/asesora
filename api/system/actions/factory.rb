require_relative 'hello_world'


module Actions
  class Salutations
    def self.greet(name)
      context = ActionContext.new(Actions::HelloWorld)
      context.add(:name, name)
      context
    end
  end

  

  class ActionContext
    def initialize(action)
      @action = action
      @context= {}
    end

    def add(key, value)
      @context[key]=value
    end

    def in_board (board)
      add( :board, board)
      self
    end

    def do
      @action.do(@context)
    end

  end

end
