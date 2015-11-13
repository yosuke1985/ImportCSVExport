class ImportsController < ApplicationController
  def index
  end

  def yaritori
    @imports = Import.all
    respond_to do |format|
      format.html
      format.csv { send_data @imports.to_csv }
      format.xls
      end
  end

  def import
  Import.import(params[:file])
  redirect_to yaritori_path, notice: "Products imported"
  end


end
