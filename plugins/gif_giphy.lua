
function getGiphyGif(text)
  local api = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
  print(api..url_encode(text))
  b = http.request(api..url_encode(text))
  local gifres = json:decode(b)

  if (gifres.meta.status == 200) then -- OK
    print(gifres.data.image_url)
    return gifres.data.image_url
  else
    return nil
  end
end

function run(msg, matches)
  local receiver = get_receiver(msg)
  local text = msg.text:sub(6,-1)
  local url = getGiphyGif(text)
  if (url == nil) then
    return "Zzzz..."
  else
    local file_path = download_to_file(url)
    print(file_path)
    send_document(receiver, file_path, ok_cb, false)
    return nil
  end
end

return {
    description = "search GIF with Giphy API and sends it",
    usage = "!gif [topic]",
    patterns = {"^!gif (.*)$"},
    run = run
}

