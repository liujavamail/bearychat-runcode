process = require('child_process')
_ = require ('lodash')
fs = require('fs')
module.exports = (robot) ->
  robot.listen(
    (message) ->
      message.text.slice(7)
    (response) ->
      fact = response.match
      if fact.match(/```ruby/)
        execute_ruby(response, fact)
      else
        if fact.match(/```js/)
          execute_js(response, fact)
      # console.log(_.split(response.text, "```", 3))

      # fact = response.match
      # fs.appendFileSync('runcode.rb', fact, 'utf8')
      # process.exec('ruby runcode.rb', (error, stdout, stderr) ->
      #   if error
      #     response.send stderr
      #   else
      #     response.send stdout
      #   fs.unlink('runcode.rb')
      # )
  )

  execute_ruby = (response, text) ->
    code_body = _.replace(text, "```ruby", '')
    code_body = _.replace(code_body, "```", '')
    fs.appendFileSync('runcode.rb', code_body, 'utf8')
    process.exec('ruby runcode.rb', (error, stdout, stderr) ->
      if error
        response.send stderr
      else
        response.send stdout
      fs.unlink('runcode.rb')
    )

  execute_js = (response, text) ->
    code_body = _.replace(text, "```js", '')
    code_body = _.replace(code_body, "```", '')
    fs.appendFileSync('runcode.js', code_body, 'utf8')
    process.exec('node runcode.js', (error, stdout, stderr) ->
      if error
        response.send stderr
      else
        response.send stdout
      fs.unlink('runcode.js')
    )
