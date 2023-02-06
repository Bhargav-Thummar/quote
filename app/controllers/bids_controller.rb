class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  def index
    @bids = BidSearchQuery.search(current_company.id, params).decorate
  end

  def show
    @line_item_dates = @bid.line_item_dates.includes(:line_items).ordered
  end

  def new
    @bid = Bid.new
  end

  def create
    @bid = current_company.bids.build(bid_params)

    if @bid.save
      respond_to do |format|
        format.html { redirect_to bids_path, notice: "Bid was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Bid was successfully created." }
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @bid.update(bid_params)
      respond_to do |format|
        format.html { redirect_to bids_path, notice: "Bid was successfully updated."}
        format.turbo_stream { flash.now[:notice] = "Bid was successfully updated." }
      end
    else
      render :edit
    end
  end

  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_path, notice: "Bid was successfully destroyed."}
      format.turbo_stream { flash.now[:notice] = "Bid was successfully destroyed." }
    end
  end

  private

  def set_bid
    @bid = current_company.bids.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:name)
  end
end
