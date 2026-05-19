# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# frozen_string_literal: true

# 古い絵文字タグを削除
old_names = ['😊 喜び', '😢 悲しみ', '😌 穏やか', '🌟 感動', '😮 驚き']
Emotion.where(name: old_names).each(&:destroy)

# 新しいタグを登録
[
  '楽しかった',
  '最高！',
  'のんびり',
  '発見！',
  '懐かしかった',
  '切なかった',
  '残念だった',
  'しんどかった',
  'おいしかった',
  '幸せ',
  '感動した',
  '達成感',
].each do |name|
  Emotion.find_or_create_by!(name: name)
end
