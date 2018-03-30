# = Entriesコントローラ
class EntriesController < ApplicationController
  # === 仕訳一覧画面を表示
  def index
    set_search_term
    query = Entry.includes(:entry_details).references(:entry_details)
    @entries = query.where(entry_date: @start_date...@end_date)
  end

  # === 仕訳登録画面を表示
  def new
    @entry = Entry.new
    @entry.debit_details.build
    @entry.credit_details.build
  end

  # === 仕訳登録処理
  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to entries_path, notice: "仕訳情報を登録しました"
    else
      render :new
    end
  end

  # === 仕訳編集画面を表示
  def edit
    @entry = Entry.find(params[:id])
  end

  # === 仕訳更新処理
  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to entries_path, notice: "仕訳情報を更新しました"
    else
      render :edit
    end
  end

  # === 仕訳削除処理
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_path, notice: "仕訳情報を削除しました"
  end


  private

  # === パラメータ項目の許可処理
  def entry_params
    params.require(:entry).permit(:entry_date, :supplier_id, :note,
      debit_details_attributes: [:kind, :item_code, :money, :_destroy, :id],
      credit_details_attributes: [:kind, :item_code, :money, :_destroy, :id])
  end
end
