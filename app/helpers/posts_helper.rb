# frozen_string_literal: true

module PostsHelper
  EMOTION_ICONS = {
    '楽しかった' => 'ti-mood-happy',
    '最高！' => 'ti-mood-heart',
    'のんびり' => 'ti-feather',
    '発見！' => 'ti-compass',
    '懐かしかった' => 'ti-clock',
    '切なかった' => 'ti-heart-broken',
    '残念だった' => 'ti-mood-sad',
    'しんどかった' => 'ti-mood-sad-dizzy',
    'おいしかった' => 'ti-tools-kitchen-2',
    '幸せ' => 'ti-heart',
    '感動した' => 'ti-sparkles',
    '達成感' => 'ti-trophy'
  }.freeze

  def emotion_icon(name)
    EMOTION_ICONS[name] || 'ti-mood-smile'
  end
end