class Relationship < ApplicationRecord
belongs_to :follower, class_name: "User"

belongs_to :followed, class_name: "User"

#belong→関連性が多い側から親要素を記載
#Userテーブルからfollowerカラムを呼び出してもらうように設定

end
