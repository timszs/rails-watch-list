class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show edit update destroy]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      # No need for app/views/bookmarks/create.html.erb
      redirect_to bookmark_path(@bookmark)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    # No need for app/views/bookmarks/destroy.html.erb
    redirect_to bookmarks_path, status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :references.movie, :references.list)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
