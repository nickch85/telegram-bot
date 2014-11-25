local f = io.open('./res/eight_ball_replies.json', "r+")
if f == nil then
  f = io.open('./res/eight_ball_replies.json', "w+")
  f:write("{}") -- Write empty table
  f:close()
  _eight_ball_replies = {}
else
  local c = f:read "*a"
  f:close()
  _eight_ball_replies = json:decode(c)
end

function answer_question()
  local answer = _eight_ball_replies[math.random(1,#_eight_ball_replies)]
  return answer
end

function run(msg, matches)
  local text = answer_question()
  return "The magic 8 ball answers: "..text
end

return {
    description = "Ask 8 ball a question",
    usage = "!8ball [question] or !ask [question]",
    patterns = {"^!8ball (.+)", "^!ask (.+)"},
    run = run
}

