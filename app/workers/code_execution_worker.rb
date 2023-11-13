class CodeExecutionWorker
  include Sidekiq::Worker

  def perform(user_code_id)
    user_code = UserCode.find(user_code_id)
    # Add code execution logic here
    result = execute_code(user_code.code_content, user_code.programming_language)
    user_code.update(output: result)
  rescue StandardError => e
    user_code.update(output: "Error: #{e.message}")
  end

  private

  def execute_code
    begin
      case programming_language
      when "Ruby"
        execute_ruby_code
      when "JavaScript"
        execute_javascript_code
      when "Python"
        execute_python_code
      end
        rescue StandardError => e
      log_execution_error(e)
      return { success: false, error: "Error executing code. Please check your code and try again." }
    end
  end

  def suggest
    prompt = "in #{language}, suggest improvements to this code: #{code}"
    response = OpenAi::Codex.complete(prompt: prompt, temperature: 0.5)

    suggestion = response["choices"].first["text"]

    {
      language: language,
      suggestion: suggestion
    }
  end

  def run
    runner = Runner.new(language, code)
    runner.execute
  end

  private
  
  def sanitize_code
    self.code_content = code_content.gsub(/<script>|<\/script>/, "") 
  end

  def execute_ruby_code
    result = `ruby -e "#{code_content}"`
    { success: true, result: result }
  end

  def execute_javascript_code
    node_server = NodeJsServer.new
    result = node_server.execute(code_content)
    { success: true, result: result }
  end

  def execute_python_code
    repl_it = ReplItService.new
    result = repl_it.execute_python_code(code_content)
    { success: true, result: result }
  end

  def log_execution_error(error)
    Rails.logger.error("Code execution error: #{error.message}")
  end
end