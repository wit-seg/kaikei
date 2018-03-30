# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# === 管理者ユーザを追加登録
puts "* users"
User.delete_all
User.create!(login: "admin", password: "password", password_confirmation: "password")


# === 勘定科目データを登録
puts "* items"
Item.delete_all
item_records = [
  { code: "1111-4", name: "現金", short_name: "現金" },
  { code: "1113", name: "普通預金", short_name: "普通預金" },
  { code: "1122", name: "売掛金", short_name: "売掛金" },
  { code: "1154", name: "未収金（未収入金）", short_name: "未収金（未収入金）" },
  { code: "1156", name: "仮払金", short_name: "仮払金" },
  { code: "1225-2", name: "減価償却累計額", short_name: "減価償却累計額" },
  { code: "2112", name: "買掛金", short_name: "買掛金" },
  { code: "2113", name: "短期借入金", short_name: "短期借入金" },
  { code: "2114", name: "未払金", short_name: "未払金" },
  { code: "2117", name: "預り金", short_name: "預り金" },
  { code: "2125", name: "未払法人税等", short_name: "未払法人税等" },
  { code: "2212", name: "長期借入金", short_name: "長期借入金" },
  { code: "5211", name: "商品仕入高", short_name: "商品仕入高" },
  { code: "5213", name: "仕入値引・戻し高", short_name: "仕入値引・戻し高" },
  { code: "6111-9", name: "販売員給与", short_name: "販売員給与" },
  { code: "6113", name: "広告宣伝費", short_name: "広告宣伝費" },
  { code: "6115", name: "発送配達費", short_name: "発送配達費" },
  { code: "6115", name: "発送配達費", short_name: "発送配達費" },
  { code: "6116-8", name: "車輌費", short_name: "車輌費" },
  { code: "6117", name: "その他の販売費", short_name: "その他の販売費" },
  { code: "6118", name: "支払手数料", short_name: "支払手数料" },
  { code: "6213", name: "販売員賞与", short_name: "販売員賞与" },
  { code: "6214-1", name: "減価償却費", short_name: "減価償却費" },
  { code: "6215", name: "地代家賃", short_name: "地代家賃" },
  { code: "6216", name: "修繕費", short_name: "修繕費" },
  { code: "6217", name: "事務用消耗品費", short_name: "事務用消耗品費" },
  { code: "6218", name: "通信交通費", short_name: "通信交通費" },
  { code: "6219", name: "水道光熱費", short_name: "水道光熱費" },
  { code: "6221", name: "租税公課", short_name: "租税公課" },
  { code: "6222", name: "寄附金", short_name: "寄附金" },
  { code: "6223", name: "接待交際費", short_name: "接待交際費" },
  { code: "6224", name: "保険料", short_name: "保険料" },
  { code: "6225", name: "備品・消耗品費", short_name: "備品・消耗品費" },
  { code: "6226-5", name: "厚生費", short_name: "厚生費" },
  { code: "6227", name: "管理諸費", short_name: "管理諸費" },
  { code: "6231", name: "雑費", short_name: "雑費" },
  { code: "7511", name: "支払利息割引料", short_name: "支払利息割引料" },
  { code: "7512", name: "貸倒引当金繰入（貸倒れ償却）☆", short_name: "貸倒引当金繰入" },
  { code: "4111", name: "売上高", short_name: "売上高" },
  { code: "4113", name: "その他の商品売上高", short_name: "その他の商品売上高" },
  { code: "4115-2", name: "売上値引・戻り高", short_name: "売上値引・戻り高" },
  { code: "7111-8", name: "受取利息・割引料", short_name: "受取利息・割引料" },
  { code: "7118-3", name: "雑益（雑収入）", short_name: "雑益（雑収入）" }
]
item_records.each do |record|
  Item.create!(record)
end


# === 取引先データを登録
puts "* suppliers"
Supplier.delete_all
supplier_records = [
  { name: "社員" },
  { name: "卸業者A" },
  { name: "B商店" },
  { name: "C銀行" },
  { name: "D商店" },
  { name: "E商店" },
  { name: "取引先F" },
  { name: "取引先G" }
]
supplier_records.each do |record|
  Supplier.create!(record)
end


# === 仕訳データ（サンプル）を登録
puts "* entries"
Entry.delete_all
entry_records = [
  { entry_date: "2018/03/02", note: "商品陳列ケースなど買い入れ", supplier_id: 2, details: [
    { kind: 1, item_code: "6225", money: 250000 },
    { kind: 2, item_code: "1111-4", money: 250000 }
  ] },
  { entry_date: "2018/03/08", note: "B商店から仕入れ", supplier_id: 3, details: [
    { kind: 1, item_code: "5211", money: 300000 },
    { kind: 2, item_code: "2112", money: 300000 }
  ] },
  { entry_date: "2018/03/13", note: "C銀行から借り入れ", supplier_id: 4, details: [
    { kind: 1, item_code: "1111-4", money: 150000 },
    { kind: 2, item_code: "2113", money: 150000 }
  ] },
  { entry_date: "2018/03/17", note: "D商店に売り渡し", supplier_id: 5, details: [
    { kind: 1, item_code: "1111-4", money: 140000 },
    { kind: 2, item_code: "4111", money: 110000 },
    { kind: 2, item_code: "7118-3", money: 30000 }
  ] },
  { entry_date: "2018/03/20", note: "E商店に売り渡し", supplier_id: 6, details: [
    { kind: 1, item_code: "1111-4", money: 100000 },
    { kind: 1, item_code: "1122", money: 90000 },
    { kind: 2, item_code: "4111", money: 150000 },
    { kind: 2, item_code: "7118-3", money: 40000 }
  ] },
  { entry_date: "2018/03/22", note: "B商店に買掛金支払い", supplier_id: 3, details: [
    { kind: 1, item_code: "2112", money: 70000 },
    { kind: 2, item_code: "1111-4", money: 70000 }
  ] },
  { entry_date: "2018/03/25", note: "本月分給料支払", supplier_id: 1, details: [
    { kind: 1, item_code: "6111-9", money: 150000 },
    { kind: 2, item_code: "1111-4", money: 150000 }
  ] },
  { entry_date: "2018/03/27", note: "E商店から売掛金回収", supplier_id: 6, details: [
    { kind: 1, item_code: "1111-4", money: 80000 },
    { kind: 2, item_code: "1122", money: 80000 }
  ] },
  { entry_date: "2018/03/28", note: "C銀行に支払い", supplier_id: 4, details: [
    { kind: 1, item_code: "2113", money: 110000 },
    { kind: 1, item_code: "6118", money: 1000 },
    { kind: 2, item_code: "1111-4", money: 111000 }
  ] }
]

entry_records.each do |record|
  entry = Entry.create(entry_date: record[:entry_date], note: record[:note], supplier_id: record[:supplier_id])
  record[:details].each do |detail|
    entry.entry_details.build(detail)
  end
  entry.save!
end
