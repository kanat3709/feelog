# app/helpers/application_helper.rb
module ApplicationHelper
  EMOTION_EMOJIS = {
    "楽しかった"     => "😊",
    "感動した"        => "😍",
    "悲しかった"     => "😭",
    "怒った"          => "😡",
    "リラックスした" => "😌"
  }.freeze

  def emotion_emoji(name)
    EMOTION_EMOJIS.fetch(name.to_s, "🙂")
  end
end