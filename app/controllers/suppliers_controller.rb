# = Suppliersコントローラ 取引先マスタ
class SuppliersController < ApplicationController
  
  # === 取引先一覧
  def index
    @suppliers = Supplier.page(params[:page]).per(5)
    
    # for create PDF
    respond_to do |format|
      format.html
      format.pdf do
        @suppliers = Supplier.all
        render pdf: "pdfname",
               encording: "UTF-8",
               template: "suppliers/index",
               layout: 'pdf.html'
      end
    end    
  end
  
  # === 取引先新規登録画面表示
  def new
    @supplier = Supplier.new
  end

  # === 取引先登録処理
  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to suppliers_path, notice: "取引先情報を登録しました"
    else
      render :new
    end
  end

  # === 取引先変更画面表示
  def edit
    @supplier = Supplier.find(params[:id])
  end

  # === 取引先更新処理
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      redirect_to suppliers_path, notice: "取引先情報を更新しました"
    else
      render :edit
    end
  end

  # === 取引先削除処理
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to suppliers_path, notice: "取引先情報を削除しました"
  end
  
  private
  
  # === パラメータ項目の許可処理
  def supplier_params
    params.require(:supplier).permit(:name)
  end

end
