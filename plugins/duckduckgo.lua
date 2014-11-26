function getDDG(text)
  local topic = string.match(text, "!ddg (.+)")
  topic = url_encode(topic)
  b = http.request("http://api.duckduckgo.com/?format=json&q=" .. topic)
  res = json:decode(b)
  local result = nil
  if res.Definition ~= "" then
    result = res.Heading..": "..res.Definition.."\n".. res.DefinitionURL
  elseif res.AbstractText ~= "" then
    result = res.Heading..": "..res.AbstractText.."\n".. res.AbstractURL
  else
    result = nil
  end
  return result
end

function url_encode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w %-%_%.%~])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
  return str
end

function run(msg, matches)
  local text = getDDG(msg.text)
  if (text == nil) then
    return "Zzzzz..."
  else
    return text
  end
end

return {
    description = "get duck duck go instant result",
    usage = "!ddg [topic]",
    patterns = {"^!ddg (.*)$"},
    run = run
}

