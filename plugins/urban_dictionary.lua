function getUrbanDictionary(text)
  local topic = string.match(text, "!ud (.+)")
  topic = url_encode(topic)
  b = http.request("http://api.urbandictionary.com/v0/define?term=" .. topic)
  res = json:decode(b)
  local definition = nil
  if #res.list > 0 then
    definition = res.list[1].word..": "..res.list[1].definition.."\n".. res.list[1].permalink
  else
    definition = nil
  end
  return definition
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
  local text = getUrbanDictionary(msg.text)
  if (text == nil) then
    return "Zzzzz..."
  else
    return text
  end
end

return {
    description = "get urban dictionary definition",
    usage = "!ud [topic]",
    patterns = {"^!ud (.*)$"},
    run = run
}

