# = Itemsコントローラ　勘定科目マスタ
class ItemsController < ApplicationController
  
  # === 勘定科目一覧
  def index
    @items = Item.order(:code).page(params[:page]).per(10)
  end
  
  # === 勘定科目新規登録画面表示
  def new
    @item = Item.new
  end

  # === 勘定科目登録処理
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: "勘定科目情報を登録しました"
    else
      render :new
    end
  end

  # === 勘定科目変更画面表示
  def edit
    @item = Item.find(params[:id])
  end

  # === 勘定科目更新処理
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path, notice: "勘定科目情報を更新しました"
    else
      render :edit
    end
  end

  # === 勘定科目削除処理
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, notice: "勘定科目情報を削除しました"
  end
  
  private
  
  # === パラメータ項目の許可処理
  def item_params
    params.require(:item).permit(:code, :name, :short_name)
  end
  
end
