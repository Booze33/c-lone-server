class OpenaiService
  def self.generate_code_suggestion(prompt)
    response = OpenAI.Completion.create(
      engine: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 100,
      n: 3
    )

    response['choices'][0]['text']
  end
end
