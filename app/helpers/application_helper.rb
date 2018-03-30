# = Applicationヘルパー
module ApplicationHelper
  # === 年選択肢
  # 仕訳データに登録されている年＋現在年を、降順にして返す
  # NOTE: SQLiteのstrftime関数を使用しているため他DBに移植する場合は要注意
  # ==== 戻り値
  # 年の選択肢を降順にした配列を返す
  def year_options
    #options = Entry.pluck("strftime('%Y', entry_date) AS entry_year")←SQLite用
    options = Entry.pluck("DATE_FORMAT(entry_date, '%Y') AS entry_year")
    options << Date.today.year.to_s
    return options.uniq.sort.reverse
  end

  # === 月選択肢
  # ==== 戻り値
  # 月の選択肢を配列で返す
  def month_options
    return 1..12
  end

  # === 取引先選択肢
  # ==== 戻り値
  # 取引先の選択肢を配列で返す
  def supplier_options
    return Supplier.all.pluck(:name, :id).unshift(["　", ""])
  end

  # === 貸借区分選択肢
  # ==== 戻り値
  # 貸借区分の選択肢を配列で返す
  def kind_options
    return [["　", ""], ["借方", 1], ["貸方", 2]]
  end

  # === 勘定科目選択肢
  # ==== 戻り値
  # 勘定科目の選択肢を配列で返す
  def item_options
    return Item.order(:code).map{|i| ["#{i.code}: #{i.short_name}", i.code] }.unshift(["　", ""])
  end

  # === 入力フィールド追加のリンク
  # ==== 引数
  # * name: リンク文字列
  # * f: フォームオブジェクト
  # * associarion: アソシエーション
  # * kind: 種別
  def link_to_add_fields(name, f, association, kind)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('form_detail', f: builder, kind: kind)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
