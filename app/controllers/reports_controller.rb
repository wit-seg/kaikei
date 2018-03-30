# = Reportsコントローラ
class ReportsController < ApplicationController
  before_action :set_search_term

  # === 仕訳帳出力画面を表示
  def output_journal
  end

  # === 仕訳帳出力処理
  def journal
    report = Thinreports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'journal.tlf')
    report.start_new_page

    # 検索条件となる年月を出力
    report.page.item(:year_month).value("#{params[:year]}年#{params[:month]}月")

    sum_debit_money = 0
    sum_credit_money = 0

    # 明細行を出力
    journal_records(params[:year], params[:month]).each do |record|
      report.list(:default).add_row do |row|
        row.values day: record[:day],
                   debit_item: record[:debit_item],
                   debit_money: record[:debit_money],
                   credit_item: record[:credit_item],
                   credit_money: record[:credit_money],
                   note: record[:note]
      end
      sum_debit_money += record[:debit_money].to_i
      sum_credit_money += record[:credit_money].to_i
    end

    # フッタに合計値を出力
    report.list(:default).on_footer_insert do |footer|
      footer.item(:sum_debit_money).value(sum_debit_money)
      footer.item(:sum_credit_money).value(sum_credit_money)
    end
    
    send_data report.generate, filename: 'journal.pdf', 
                               type: 'application/pdf', 
                               disposition: 'inline'
  end

  # === 総勘定元帳出力画面を表示
  def output_general_ledger
  end

  # === 総勘定元帳出力処理
  def general_ledger
    report = Thinreports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'general_ledger.tlf')

    general_ledger_records(params[:year], params[:month]).each do |item|
      report.start_new_page

      # 検索条件となる年月を出力
      report.page.item(:year_month).value("#{params[:year]}年#{params[:month]}月")

      report.page.item(:item_name).value(item[:item_name])

      item[:records].each do |record|
        report.list(:default).add_row do |row|
          row.values day: record[:day],
                     note: record[:note],
                     debit_money: record[:debit_money],
                     credit_money: record[:credit_money],
                     supplier_name: record[:supplier_name]
        end
      end
    end

    send_data report.generate, filename: 'journal.pdf', 
                               type: 'application/pdf', 
                               disposition: 'inline'
  end


  private

  # === 仕訳帳データを返す
  # ==== 引数
  # * year: 年
  # * month: 月
  # ==== 戻り値
  # 仕訳帳データ
  def journal_records(year, month)
    records = []
    query = Entry.includes(:entry_details).references(:entry_details)
    entries = query.where(entry_date: @start_date...@end_date)

    entries.each do |entry|
      debit_details = entry.debit_details
      credit_details = entry.credit_details

      record = {
        day: entry.entry_date.strftime("%m/%d"),
        debit_item: debit_details.first.item.try(:short_name),
        debit_money: debit_details.first.money,
        credit_item: credit_details.first.item.try(:short_name),
        credit_money: credit_details.first.money,
        note: entry.note
      }

      ["debit", "credit"].each do |kind|
        if eval("#{kind}_details").length > 1
          record[:"#{kind}_item"] = "諸口"
          record[:"#{kind}_money"] = nil
        end
      end

      records << record

      # NOTE: 諸口の場合の残りの行をセット
      ["debit", "credit"].each do |kind|
        if eval("#{kind}_details").length > 1
          eval("#{kind}_details").each do |detail|
            records << {
              :"#{kind}_item" => detail.item.short_name,
              :"#{kind}_money" => detail.money,
            }
          end
        end
      end
    end

    return records
  end

  # === 総勘定元帳データを返す
  # ==== 引数
  # * year: 年
  # * month: 月
  # ==== 戻り値
  # 総勘定元帳データ
  def general_ledger_records(year, month)
    items = []
    Item.all.each do |item|
      item_record = {
        item_name: item.name,
        records: []
      }

      query = Entry.includes(:entry_details).references(:entry_details)
      query = query.where(entry_date: @start_date...@end_date)
      query = query.where("entry_details.item_code = ?", item.code)
      entries = query.order(:entry_date)
      next if entries.empty?

      entries.each do |entry|
        record = {
          day: entry.entry_date.strftime("%m/%d"),
          note: entry.note,
          debit_money: nil,
          credit_money: nil,
          supplier_name: entry.supplier.name
        }
        entry.entry_details.each do |detail|
          record[:debit_money] = record[:credit_money] = nil
          record[:debit_money] = detail.money if detail.kind == Entry::KIND[:DEBIT]
          record[:credit_money] = detail.money if detail.kind == Entry::KIND[:CREDIT]
          item_record[:records] << record
        end
      end
      items << item_record
    end

    return items
  end
end
